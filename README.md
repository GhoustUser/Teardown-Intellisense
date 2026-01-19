# Teardown Lua API

A Visual Studio Code extension which adds intellisense for most features in the [Teardown scripting API (2.0.0 // Experimental)](https://teardowngame.com/experimental/api.html).

### Note:
This is my first VS Code extension and public coding project, so any help, advice or feedback is appreciated.

## What it does

- Adds intellisense for the Teardown Lua scripting API (must be enabled per-workspace).
- The extension only turns on if it finds an `info.txt` file in the root folder of the workspace.

## Usage

Opening a workspace with an `info.txt` for the first time with the extension installed, you should get a popup letting you enable intellisense.

It can always be toggled in the workspace settings as well.

## Installation

I will try to get this on the VSCode extension marketplace at some point, but for now you can install it using the included `.vsix` file.
> Open the **extensions** tab, then click on the three dots in the top right `⋯`, then select **`Install from VSIX...`**

## Settings:

- **`Enable Scripting API`** : Enables or disables the Teardown scripting API intellisense for this project.
- **`Show Prompt`** : Used by the extension to make sure the popup is only shown once.

## How it works

The extension adds `.meta.lua` files to the Lua Language Server's workspace library. This does not add, modify or remove any files from your project, it just tells VS Code that the type definitions are part of the workspace.

## Links
- [Teardown Game](https://teardowngame.com) - The game this is for
- [Teardown API (Experimental)](https://teardowngame.com/experimental/api.html) - docs for the scripting API