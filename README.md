# Teardown Lua API

Work-in-progress VS Code extension for Teardown modding. Will include type definitions for the [Teardown scripting API](https://teardowngame.com/experimental/api.html), and a custom interface for getting an overview of your mod and managing settings.

### Note:
This is my first VS Code extension, and I've never published any of my coding projects, so any help, advice or feedback is appreciated.

## What it does

- Currently adds *some* of Teardown's Lua features to your autocomplete *(still a work-in-progress, there's a lot of them)*.
- Adds a custom interface that shows your mod info, lets you edit it, and lets you change some workspace-specific modding settings.
- The extension only turns on when it finds an `info.txt` file in the root folder.

## Installation

I'm not very experienced with publishing coding projects, and it's not finished yet, so you'll need to install it manually using the included `.vsix`-file:
> Open the **extensions** tab, then click on the three dots in the top right `⋯`, then select **`Install from VSIX...`**

I have included `launch.json` and `tasks.json` in the `.VS Code` folder, so you should be able to compile and debug normally.

## Usage

With the extension enabled, open a project with an open folder containing an `info.txt` file, and the extension will automatically activate. You'll get a popup with a button to open the Mod View, which can also be opened at any time from the command palette: 
> `Ctrl + Shift + p` > `Open Teardown Mod View`

This opens a custom interface where you can view and change info about your mod, as well as change some settings.
I'm planning on adding more info to get a good overview, like whether it's a global or content mod, a list of any included characters, and more.

## Settings:
- **`Open Mod View by default`** : Whether or not the mod view should open whenever you open the project.
- **`Enable Teardown Lua API`** : Enables or disables the Teardown API for this project.

Will probably add more settings at some point.

## API progress

The current progress per category for implementing type definitions of the API:
  - [x] Parameters
  - [ ] Script control (in progress)
  - [ ] Registry
  - [ ] Events
  - [ ] Vector math
  - [ ] Entity
  - [ ] Body
  - [ ] Shape
  - [ ] Location
  - [ ] Joint
  - [ ] Animation
  - [ ] Light
  - [ ] Trigger
  - [ ] Screen
  - [ ] Vehicle
  - [ ] Rig
  - [ ] Player
  - [ ] Sound
  - [ ] Sprite
  - [ ] Scene queries
  - [ ] Particles
  - [ ] Spawn
  - [ ] Miscellaneous
  - [ ] User Interface

I'm currently just writing these manually, since the documentation isn't very easily scrape-able as far as I can tell. If you know a way to generate the lua meta definitions, please let me know.

## How it works

The extension adds `.meta.lua` files into the Lua Language Server's workspace library, providing type definitions and function signatures for Teardown's API. This does not add, modify or remove any files from your project, it just tells VS Code that the meta definitions should be accessible for your workspace.

The custom interface is implemented as a VS Code webview.

The Lua type definitions are located in files under `teardown-lua-api/*.meta.lua`, with one file for each category.

## Links
- [Teardown Game](https://teardowngame.com) - the game this is for
- [Teardown API (Experimental)](https://teardowngame.com/experimental/api.html) - docs for the aforementioned API

See `TODO.md` for planned changes and additions.