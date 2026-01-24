import path from "path";
import VscManager from "./vsc-manager";

/** Configuration for managing Lua workspace settings.
 * @type {Object}
 */
interface LuaSettingsConfig {
    /** Array settings where items should be added/removed */
    arraySettings: {
        /** Setting key to modify */
        settingKey: string;
        /** Items to add when enabling */
        itemsToAdd: string[];
        /** Filter function to remove items when disabling */
        filterOut: (item: string) => boolean;
    }[];
    /** Simple value settings to enable/disable */
    valueSettings: {
        /** Setting key to modify */
        settingKey: string;
        /** Value to set when enabling */
        enableValue: any;
        /** Value to set when disabling (undefined to remove setting) */
        disableValue: any;
    }[];
}

/** Enables or disables the Teardown Lua API in the VSCode Lua workspace configuration.
 * @param {boolean} enable - Whether to enable or disable the scripting API
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function configureTDIntellisense(enable: boolean, vscManager: VscManager): void {
    const luaApiPath = path.join(vscManager.context.extensionPath, "api-definitions");

    // define what settings to configure
    const config: LuaSettingsConfig = {
        arraySettings: [
            {
                settingKey: "Lua.workspace.library",
                itemsToAdd: [luaApiPath],
                filterOut: (item: string) => item.toLowerCase().includes("teardown")
            },
            {
                settingKey: "Lua.diagnostics.disable",
                itemsToAdd: ["duplicate-set-field"],
                filterOut: (item: string) => item === "duplicate-set-field"
            }
        ],
        valueSettings: [
            {
                settingKey: "Lua.runtime.plugin",
                enableValue: path.join(vscManager.context.extensionPath, "editor-plugin.lua"),
                disableValue: undefined
            },
            {
                settingKey: "Lua.runtime.version",
                enableValue: "Lua 5.1",
                disableValue: undefined
            },
        ]
    };

    // apply configuration for each array setting
    for (const arraySetting of config.arraySettings) {
        updateArraySetting(arraySetting, enable, vscManager);
    }

    // apply configuration for each value setting
    for (const valueSetting of config.valueSettings) {
        updateValueSetting(valueSetting, enable, vscManager);
    }
}

/** Updates an array-based VSCode setting by adding/removing items.
 * @param {Object} config - Configuration for the array setting
 * @param {string} config.settingKey - The setting key to modify
 * @param {string[]} config.itemsToAdd - Items to add when enabling
 * @param {Function} config.filterOut - Function to identify items to remove
 * @param {boolean} enable - Whether to add or remove items
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function updateArraySetting(
    config: { settingKey: string; itemsToAdd: string[]; filterOut: (item: string) => boolean },
    enable: boolean,
    vscManager: VscManager
): void {
    const currentArray = vscManager.getSetting(config.settingKey, []);

    // filter out items that should be removed
    const filteredArray = currentArray.filter((item: string) => !config.filterOut(item));

    // determine final array based on enable flag
    const updatedArray = enable ?
        [...filteredArray, ...config.itemsToAdd] :
        filteredArray;

    // update setting (remove if empty, otherwise set new value)
    const newValue = updatedArray.length === 0 ? undefined : updatedArray;
    vscManager.updateSetting(config.settingKey, newValue, false);
}

/** Updates a simple value-based VSCode setting.
 * @param {Object} config - Configuration for the value setting
 * @param {string} config.settingKey - The setting key to modify
 * @param {any} config.enableValue - Value to set when enabling
 * @param {any} config.disableValue - Value to set when disabling
 * @param {boolean} enable - Whether to use enable or disable value
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function updateValueSetting(
    config: { settingKey: string; enableValue: any; disableValue: any },
    enable: boolean,
    vscManager: VscManager
): void {
    const newValue = enable ? config.enableValue : config.disableValue;
    vscManager.updateSetting(config.settingKey, newValue, false);
}

export { configureTDIntellisense };
