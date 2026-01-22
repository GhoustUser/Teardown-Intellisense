# Teardown Intellisense

A Visual Studio Code extension which adds intellisense for the [Teardown scripting API (2.0.0 // Experimental)](https://teardowngame.com/experimental/api.html) using the API files provided in the Teardown game directory.

## Usage

Opening a workspace with an `info.txt` for the first time with the extension installed, you should get a popup in the bottom right which lets you enable intellisense.

It can always be enabled/disabled in the extension settings, or by running `TeardownIntellisense.toggleIntellisense` in the command palette.

**Important:** The extension only turns on if it finds an `info.txt` file in the root folder of the workspace when opened. If you add the file afterwards, simply reopen the editor and the popup should appear.

## Settings:

- **`Teardown Directory`** : Path to the Teardown installation directory.
- **`Enable Intellisense`** : Enables or disables intellisense for the Teardown scripting API.
- **`Show Prompt`** : Whether to show the popup when opening a valid workspace for the first time.

## How it works

The extension adds references to the Lua type definitions provided in the Teardown game files to the Lua Language Server's workspace library. This does not add, modify or remove any files from your project, it just tells VS Code that the type definitions are part of the workspace.

If no game directory is set in the settings, it will attempt to find it. If the directory can't be found, a popup will appear asking you to set the directory in the extension settings.

## Links
- [Teardown Game](https://teardowngame.com) - The game this is for
- [Teardown API (Experimental)](https://teardowngame.com/experimental/api.html) - docs for the scripting API
