# Teardown Lua API

A Visual Studio Code extension which adds intellisense for most features in the [Teardown scripting API (2.0.0 // Experimental)](https://teardowngame.com/experimental/api.html).

Currently contains definitions for a total of `606` functions across `24` files/categories, as well as the `server` and `client` objects.

### Note:
This is my first VS Code extension and public coding project, so any help, advice or feedback is appreciated.

## Usage

Opening a workspace with an `info.txt` for the first time with the extension installed, you should get a popup in the bottom right which lets you enable intellisense.

It can always be enabled/disabled in the extension settings for the current workspace.

**Important:** The extension only turns on if it finds an `info.txt` file in the root folder of the workspace when opened. If you add the file afterwards, simply reopen the editor and the popup should appear.

## Installation

I will try to get this on the VSCode extension marketplace at some point, but for now you can install it using the included `.vsix` file.
> Open the **extensions** tab, then click on the three dots in the top right `⋯`, then select **`Install from VSIX...`**

## Settings:

- **`Enable Scripting API`** : Enables or disables the Teardown scripting API intellisense for this project.
- **`Show Prompt`** : 
  - **In User Settings:** Whether to show the popup when opening a valid workspace for the first time.
  - **In workspace settings:** Used by the extension to make sure the popup is only shown once, if enabled in user settings.

## How it works

The extension adds `.meta.lua` files to the Lua Language Server's workspace library. This does not add, modify or remove any files from your project, it just tells VS Code that the type definitions are part of the workspace.

Currently, the only requirement for a Teardown mod is having an `info.txt` in the root folder. But just because a folder has an `info.txt` file, that doesn't guarantee that it's a Teardown mod, which is why I've chosen this popup prompt approach.

## Links
- [Teardown Game](https://teardowngame.com) - The game this is for
- [Teardown API (Experimental)](https://teardowngame.com/experimental/api.html) - docs for the scripting API