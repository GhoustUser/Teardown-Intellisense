import vscode from "vscode";
import path from "path";
import fs from "fs";
import VscManager from "./vsc-manager";

    // cache for function to include mapping
const functionToIncludeMap = new Map<string, string>();
let diagnosticCollection: vscode.DiagnosticCollection;

/** Initializes dynamic intellisense and include checking system.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function setupDynamicIntellisense(vscManager: VscManager): void {
    diagnosticCollection = vscode.languages.createDiagnosticCollection('teardown-includes');

    // build function-to-include mapping
    buildFunctionMapping(vscManager);

    // register code action provider for include quick fixes
    const codeActionProvider = vscode.languages.registerCodeActionsProvider(
        { scheme: 'file', language: 'lua' },
        {
            provideCodeActions(document: vscode.TextDocument, range: vscode.Range | vscode.Selection, context: vscode.CodeActionContext): vscode.CodeAction[] {
                return getCodeActions(document, range, context);
            }
        }
    );

    // register document event listeners
    const textChangeListener = vscode.workspace.onDidChangeTextDocument((event) => {
        if (event.document.languageId === 'lua') {
            checkMissingIncludes(event.document);
        }
    });

    const openListener = vscode.workspace.onDidOpenTextDocument((document) => {
        if (document.languageId === 'lua') {
            checkMissingIncludes(document);
        }
    });

    const closeListener = vscode.workspace.onDidCloseTextDocument((document) => {
        if (document.languageId === 'lua') {
            diagnosticCollection.delete(document.uri);
        }
    });

    // check existing open documents
    const currentDocuments = vscode.workspace.textDocuments;
    for (const document of currentDocuments) {
        if (document.languageId === 'lua') {
            checkMissingIncludes(document);
        }
    }

    vscManager.context.subscriptions.push(textChangeListener, openListener, closeListener, diagnosticCollection, codeActionProvider);
}

/** Builds mapping of functions to their required include paths.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function buildFunctionMapping(vscManager: VscManager): void {
    // clear existing map
    functionToIncludeMap.clear();

    // scan extension modules first
    const modulesPath = path.join(vscManager.context.extensionPath, "api-definitions", "modules");
    if (fs.existsSync(modulesPath)) {
        scanForFunctions(path.join(modulesPath, "*"), "");
    }

    // also scan teardown game directory for actual lua files
    const teardownDirectory = vscManager.getSetting("TeardownIntellisense.teardownDirectory", "");
    if (teardownDirectory) {
        const teardownDataPath = path.join(teardownDirectory, "data");

        // get additional include paths from settings
        const additionalModules = vscManager.getSetting("TeardownIntellisense.additionalIncludePaths", [])
            // make paths relative to the Teardown data directory
            .map((relPath: string) => path.join(teardownDataPath, relPath));

        // scan each additional path
        for (const addPath of additionalModules) {
            if (fs.existsSync(addPath)) {
                // calculate relative path from data directory to maintain proper include paths
                const relativePath = path.relative(teardownDataPath, addPath).replace(/\\/g, '/');
                scanForFunctions(addPath, relativePath);
            }
        }
    }
}

/** Processes a single Lua file and extracts its functions.
 * @param {string} filePath - Absolute path to the file
 * @param {string} relativePath - Relative path from scan root
 * @returns {void}
 */
function processLuaFile(filePath: string, relativePath: string): void {
    const functions = extractFunctions(filePath);
    const fileName = path.basename(filePath);
    const currentPath = relativePath ? (relativePath.endsWith(fileName) ? relativePath : path.join(relativePath, fileName)) : fileName;

    // convert .meta.lua to .lua, keep .lua as is
    const includePath = currentPath.endsWith('.meta.lua')
        ? currentPath.replace('.meta.lua', '.lua').replace(/\\/g, '/')
        : currentPath.replace(/\\/g, '/');

    for (const funcName of functions) {
        functionToIncludeMap.set(funcName, includePath);
    }
}

/** Recursively scans directories for .lua and .meta.lua files.
 * @param {string} scanPath - Path to scan (may end with * for recursive)
 * @param {string} relativePath - Relative path from scan root
 * @returns {void}
 */
function scanForFunctions(scanPath: string, relativePath: string): void {
    // handle wildcard for recursive scanning
    const isRecursive = scanPath.endsWith('*');
    const actualPath = isRecursive ? scanPath.slice(0, -1) : scanPath;

    // check if path exists
    if (!fs.existsSync(actualPath)) {
        return;
    }

    const stats = fs.lstatSync(actualPath);

    // handle single file
    if (stats.isFile()) {
        if (actualPath.endsWith('.lua') || actualPath.endsWith('.meta.lua')) {
            processLuaFile(actualPath, relativePath);
        }
        return;
    }

    // handle directory
    if (!stats.isDirectory()) {
        return;
    }

    const entries = fs.readdirSync(actualPath, { withFileTypes: true });

    for (const entry of entries) {
        const fullPath = path.join(actualPath, entry.name);
        const currentRelativePath = relativePath ? path.join(relativePath, entry.name) : entry.name;

        if (entry.isDirectory() && isRecursive) {
            // recursively scan subdirectories
            scanForFunctions(fullPath, currentRelativePath);
        } else if (entry.isFile() && (entry.name.endsWith('.lua') || entry.name.endsWith('.meta.lua'))) {
            // process lua files using directory's relative path
            processLuaFile(fullPath, relativePath);
        }
    }
}

/** Extracts function names from a meta file or regular lua file.
 * @param {string} filePath - Path to the lua/meta file
 * @returns {string[]} Array of function names
 */
function extractFunctions(filePath: string): string[] {
    try {
        const content = fs.readFileSync(filePath, 'utf8');
        const functions: string[] = [];

        // find standard function definitions: function name(
        const standardFuncMatches = content.match(/^function\s+(\w+)\s*\(/gm);
        if (standardFuncMatches) {
            for (const match of standardFuncMatches) {
                const funcName = match.match(/function\s+(\w+)/)?.[1];
                if (funcName) {
                    functions.push(funcName);
                }
            }
        }

        // find function assignments: variableName = function(
        const assignmentFuncMatches = content.match(/^(\w+)\s*=\s*function\s*\(/gm);
        if (assignmentFuncMatches) {
            for (const match of assignmentFuncMatches) {
                const funcName = match.match(/^(\w+)\s*=/)?.[1];
                if (funcName) {
                    functions.push(funcName);
                }
            }
        }

        return functions;
    } catch {
        return [];
    }
}

/** Checks document for missing includes and adds diagnostics.
 * @param {vscode.TextDocument} document - The document to check
 * @returns {void}
 */
function checkMissingIncludes(document: vscode.TextDocument): void {
    const content = document.getText();
    const includes = extractIncludes(content);
    const functionCalls = extractFunctionCalls(content);
    const diagnostics: vscode.Diagnostic[] = [];

    for (const call of functionCalls) {
        const requiredInclude = functionToIncludeMap.get(call.name);
        if (requiredInclude && !includes.includes(requiredInclude)) {
            const diagnostic = new vscode.Diagnostic(
                call.range,
                `Function '${call.name}' requires #include "${requiredInclude}"`,
                vscode.DiagnosticSeverity.Warning
            );
            diagnostic.source = 'Teardown Intellisense';
            diagnostic.code = { value: 'missing-include', target: vscode.Uri.parse('https://teardowngame.com/modding') };
            // attach required include data for quick fix functionality
            diagnostic.relatedInformation = [
                new vscode.DiagnosticRelatedInformation(
                    new vscode.Location(document.uri, call.range),
                    `Add #include "${requiredInclude}"`
                )
            ];
            (diagnostic as any).data = { requiredInclude, functionName: call.name };
            diagnostics.push(diagnostic);
        }
    }

    diagnosticCollection.set(document.uri, diagnostics);
}

/** Extracts include statements from file content.
 * @param {string} content - File content
 * @returns {string[]} Array of include paths
 */
function extractIncludes(content: string): string[] {
    const includes: string[] = [];
    const matches = content.match(/#include\s+"([^"]+)"/g);

    if (matches) {
        for (const match of matches) {
            const path = match.match(/#include\s+"([^"]+)"/)?.[1];
            if (path) {
                includes.push(path);
            }
        }
    }

    return includes;
}

/** Extracts function calls with positions from content.
 * @param {string} content - File content
 * @returns {Array} Array of function calls with ranges
 */
function extractFunctionCalls(content: string): Array<{ name: string; range: vscode.Range }> {
    const calls: Array<{ name: string; range: vscode.Range }> = [];
    const lines = content.split('\n');

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i] || "";
        const regex = /(\w+)\s*\(/g;
        let match;

        while ((match = regex.exec(line)) !== null) {
            const funcName = match[1] || "";
            const start = match.index || 0;

            calls.push({
                name: funcName,
                range: new vscode.Range(
                    new vscode.Position(i, start),
                    new vscode.Position(i, start + funcName.length)
                )
            });
        }
    }

    return calls;
}

/** Provides code actions (quick fixes) for diagnostics.
 * @param {vscode.TextDocument} document - The document
 * @param {vscode.Range | vscode.Selection} range - The range or selection
 * @param {vscode.CodeActionContext} context - The code action context
 * @returns {vscode.CodeAction[]} Array of available code actions
 */
function getCodeActions(
    document: vscode.TextDocument,
    range: vscode.Range | vscode.Selection,
    context: vscode.CodeActionContext
): vscode.CodeAction[] {
    const actions: vscode.CodeAction[] = [];

    // filter diagnostics to this extension
    const validDiagnostics = context.diagnostics.filter(diagnostic =>
        diagnostic.source === 'Teardown Intellisense' &&
        diagnostic.code &&
        typeof diagnostic.code === 'object' &&
        diagnostic.code.value === 'missing-include'
    );

    // iterate through valid diagnostics
    for (const diagnostic of validDiagnostics) {
        const data = (diagnostic as any).data;
        if (data && data.requiredInclude) {
            // create quick fix action to add missing include statement
            const action = new vscode.CodeAction(
                `Add #include "${data.requiredInclude}"`,
                vscode.CodeActionKind.QuickFix
            );
            // associate action with the diagnostic it fixes
            action.diagnostics = [diagnostic];
            // create workspace edit that inserts the include statement
            action.edit = createIncludeEdit(document, data.requiredInclude);
            // mark as preferred for quick fix menu priority
            action.isPreferred = true;
            actions.push(action);
        }
    }

    return actions;
}

/** Creates a workspace edit to add an include statement.
 * @param {vscode.TextDocument} document - The document to edit
 * @param {string} includePath - The include path to add
 * @returns {vscode.WorkspaceEdit} The workspace edit
 */
function createIncludeEdit(document: vscode.TextDocument, includePath: string): vscode.WorkspaceEdit {
    const edit = new vscode.WorkspaceEdit();

    // find the best position to insert the include
    const insertPosition = findIncludeInsertPosition(document);
    const includeStatement = `#include "${includePath}"\n`;

    edit.insert(document.uri, insertPosition, includeStatement);
    return edit;
}

/** Finds the best position to insert a new include statement.
 * @param {vscode.TextDocument} document - The document
 * @returns {vscode.Position} The position to insert the include
 */
function findIncludeInsertPosition(document: vscode.TextDocument): vscode.Position {
    const text = document.getText();
    const lines = text.split('\n');

    let insertLine = 0;

    // locate existing includes and insert after the last one
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i]?.trim() || "";

        // skip version declarations
        if (line.startsWith('#version')) {
            insertLine = i + 1;
            continue;
        }

        // found an include, update insert position
        if (line.startsWith('#include')) {
            insertLine = i + 1;
            continue;
        }

        // stop at first non-comment, non-include line
        if (line && !line.startsWith('--') && !line.startsWith('#')) {
            break;
        }
    }

    return new vscode.Position(insertLine, 0);
}

export { setupDynamicIntellisense };
