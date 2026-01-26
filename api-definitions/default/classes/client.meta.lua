--- @meta


--- The following optional callback functions are available on the client. The client part of a script is typically used for overlay graphics and user interfaces, but it can also be used for optimization purposes to spawn local particle effects, sounds or animations.
--- @class client
--- @field init? fun() -- Called once at load time
--- @field tick? fun(dt:number) -- Called exactly once per frame. The time step is variable but always between 0.0 and 0.0333333
--- @field update? fun(dt:number) -- Called at a fixed update rate, but at the most two times per frame. Time step is always 0.0166667 (60 updates per second). Depending on frame rate it might not be called at all for a particular frame.
--- @field postUpdate? fun() -- Called like update, but after physics. Because update can trigger physics updates, it can be necessary to do some additional calculations afterwards. This is usually used by animators.
--- @field draw? fun() -- Called when the 2D overlay is being draw, after the scene but before the standard HUD. Ui functions can only be used from this callback.
--- @field render? fun(dt:number) -- Called exactly once per frame, right before things are actually drawn to the screen.
--- @field destroy? fun() -- For game mode scripts, this is called when the game mode is stopped
--- @field [string] fun(...): any -- Custom functions can be defined with `function client.myFunction(...) end` and called from the server using `ClientCall`.

--- @type client
client = client
