--- @meta


--- @param path string -- Path to ogg sound file
--- @param nominalDistance? number -- The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
--- @return number handle -- Sound handle
--- ### Example
--- ```lua
--- function client.init()
--- 	local snd = LoadSound("warning-beep.ogg")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#LoadSound)
function LoadSound(path, nominalDistance) end

--- @param handle number -- Sound handle
--- ### Example
--- ```lua
--- function client.init()
--- 	local snd = LoadSound("warning-beep.ogg")
--- 	UnloadSound(snd)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UnloadSound)
function UnloadSound(handle) end

--- @param path string -- Path to ogg sound file
--- @param nominalDistance? number -- The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
--- @return number handle -- Loop handle
--- ### Example
--- ```lua
--- local loop
--- function client.init()
--- 	loop = LoadLoop("radio/jazz.ogg")
--- end
--- function client.tick()
--- 	local pos = Vec(0, 0, 0)
--- 	PlayLoop(loop, pos, 1.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#LoadLoop)
function LoadLoop(path, nominalDistance) end

--- @param handle number -- Loop handle
--- ### Example
--- ```lua
--- local loop = -1
--- function client.init()
--- 	loop = LoadLoop("radio/jazz.ogg")
--- end
--- function client.tick()
--- 	if loop ~= -1 then
--- 		local pos = Vec(0, 0, 0)
--- 		PlayLoop(loop, pos, 1.0)
--- 	end
--- 	if InputPressed("space") then
--- 		UnloadLoop(loop)
--- 		loop = -1
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UnloadLoop)
function UnloadLoop(handle) end

--- ### CLIENT ONLY
--- @param handle number -- Loop handle
--- @param nominalDistance number -- User index
--- @return boolean flag -- TRUE if sound applied to gamepad speaker, FALSE otherwise.
--- ### Example
--- ```lua
--- function client.init()
--- 	local loop = LoadLoop("radio/jazz.ogg")
--- 	SetSoundLoopUser(loop, 0)
--- end
--- --This function will move (if possible) sound to gamepad of appropriate user
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetSoundLoopUser)
function SetSoundLoopUser(handle, nominalDistance) end

--- @param handle number -- Sound handle
--- @param pos? TVec -- World position as vector. Default is player position.
--- @param volume? number -- Playback volume. Default is 1.0
--- @param registerVolume? boolean -- Register position and volume of this sound for GetLastSound. Default is true
--- @param pitch? number -- Playback pitch. Default 1.0
--- @return number handle -- Sound play handle
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("warning-beep.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		local pos = Vec(0, 0, 0)
--- 		PlaySound(snd, pos, 0.5)
--- 	end
--- end
--- -- If you have a list of sound files and you add a sequence number, starting from zero, at the end of each filename like below,
--- -- then each time you call PlaySound it will pick a random sound from that list and play that sound.
--- -- "example-sound0.ogg"
--- -- "example-sound1.ogg"
--- -- "example-sound2.ogg"
--- -- "example-sound3.ogg"
--- -- ...
--- --[[
--- 	local snd
--- 	function client.init()
--- 		snd = LoadSound("example-sound0.ogg")
--- 	end
--- 	-- Plays a random sound from the loaded sound series
--- 	function client.tick()
--- 		if trigSound then
--- 			local pos = Vec(100, 0, 0)
--- 			PlaySound(snd, pos, 0.5)
--- 		end
--- 	end
--- ]]
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlaySound)
function PlaySound(handle, pos, volume, registerVolume, pitch) end

--- ### CLIENT ONLY
--- @param handle number -- Sound handle
--- @param user number -- Index of user to play.
--- @param pos? TVec -- World position as vector. Default is player position.
--- @param volume? number -- Playback volume. Default is 1.0
--- @param registerVolume? boolean -- Register position and volume of this sound for GetLastSound. Default is true
--- @param pitch? number -- Playback pitch. Default 1.0
--- @return number handle -- Sound play handle
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("warning-beep.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		PlaySoundForUser(snd, 0)
--- 	end
--- end
--- -- If you have a list of sound files and you add a sequence number, starting from zero, at the end of each filename like below,
--- -- then each time you call PlaySoundForUser it will pick a random sound from that list and play that sound.
--- -- "example-sound0.ogg"
--- -- "example-sound1.ogg"
--- -- "example-sound2.ogg"
--- -- "example-sound3.ogg"
--- -- ...
--- --[[
--- 	local snd
--- 	function client.init()
--- 		snd = LoadSound("example-sound0.ogg")
--- 	end
--- 	-- Plays a random sound from the loaded sound series
--- 	function client.tick()
--- 		if trigSound then
--- 			local pos = Vec(100, 0, 0)
--- 			PlaySoundForUser(snd, 0, pos, 0.5)
--- 		end
--- 	end
--- ]]
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlaySoundForUser)
function PlaySoundForUser(handle, user, pos, volume, registerVolume, pitch) end

--- @param handle number -- Sound play handle
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("radio/jazz.ogg")
--- end
--- local sndPlay
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		if not IsSoundPlaying(sndPlay) then
--- 			local pos = Vec(0, 0, 0)
--- 			sndPlay = PlaySound(snd, pos, 0.5)
--- 		else
--- 			StopSound(sndPlay)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#StopSound)
function StopSound(handle) end

--- @param handle number -- Sound play handle
--- @return boolean playing -- True if sound is playing, false otherwise.
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("radio/jazz.ogg")
--- end
--- local sndPlay
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		if not IsSoundPlaying(sndPlay) then
--- 			local pos = Vec(0, 0, 0)
--- 			sndPlay = PlaySound(snd, pos, 0.5)
--- 		else
--- 			StopSound(sndPlay)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsSoundPlaying)
function IsSoundPlaying(handle) end

--- @param handle number -- Sound play handle
--- @return number progress -- Current sound progress in seconds.
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("radio/jazz.ogg")
--- end
--- local sndPlay
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		if not IsSoundPlaying(sndPlay) then
--- 			local pos = Vec(0, 0, 0)
--- 			sndPlay = PlaySound(snd, pos, 0.5)
--- 		else
--- 			SetSoundProgress(sndPlay, GetSoundProgress(sndPlay) - 1.0)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetSoundProgress)
function GetSoundProgress(handle) end

--- @param handle number -- Sound play handle
--- @param progress number -- Progress in seconds
--- ### Example
--- ```lua
--- local snd
--- function client.init()
--- 	snd = LoadSound("radio/jazz.ogg")
--- end
--- local sndPlay
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		if not IsSoundPlaying(sndPlay) then
--- 			local pos = Vec(0, 0, 0)
--- 			sndPlay = PlaySound(snd, pos, 0.5)
--- 		else
--- 			SetSoundProgress(sndPlay, GetSoundProgress(sndPlay) - 1.0)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetSoundProgress)
function SetSoundProgress(handle, progress) end

--- Call this function continuously to play loop
--- @param handle number -- Loop handle
--- @param pos? TVec -- World position as vector. Default is player position.
--- @param volume? number -- Playback volume. Default is 1.0
--- @param registerVolume? boolean -- Register position and volume of this sound for GetLastSound. Default is true
--- @param pitch? number -- Playback pitch. Default 1.0
--- ### Example
--- ```lua
--- local loop
--- function client.init()
--- 	loop = LoadLoop("radio/jazz.ogg")
--- end
--- function client.tick()
--- 	local pos = Vec(0, 0, 0)
--- 	PlayLoop(loop, pos, 1.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayLoop)
function PlayLoop(handle, pos, volume, registerVolume, pitch) end

--- @param handle number -- Loop handle
--- @return number progress -- Current music progress in seconds.
--- ### Example
--- ```lua
--- function client.init()
--- 	loop = LoadLoop("radio/jazz.ogg")
--- end
--- function client.tick()
--- 	local pos = Vec(0, 0, 0)
--- 	PlayLoop(loop, pos, 1.0)
--- 	if InputPressed("interact") then
--- 		SetSoundLoopProgress(loop, GetSoundLoopProgress(loop) - 1.0)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetSoundLoopProgress)
function GetSoundLoopProgress(handle) end

--- @param handle number -- Loop handle
--- @param progress? number -- Progress in seconds. Default 0.0.
--- ### Example
--- ```lua
--- function client.init()
--- 	loop = LoadLoop("radio/jazz.ogg")
--- end
--- function client.tick()
--- 	local pos = Vec(0, 0, 0)
--- 	PlayLoop(loop, pos, 1.0)
--- 	if InputPressed("interact") then
--- 		SetSoundLoopProgress(loop, GetSoundLoopProgress(loop) - 1.0)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetSoundLoopProgress)
function SetSoundLoopProgress(handle, progress) end

--- @param path string -- Music path
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayMusic)
function PlayMusic(path) end

--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		StopMusic()
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#StopMusic)
function StopMusic() end

--- @return boolean playing -- True if music is playing, false otherwise.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") and IsMusicPlaying() then
--- 		DebugPrint("music is playing")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsMusicPlaying)
function IsMusicPlaying() end

--- @param paused boolean -- True to pause, false to resume.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		SetMusicPaused(IsMusicPlaying())
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetMusicPaused)
function SetMusicPaused(paused) end

--- @return number progress -- Current music progress in seconds.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		DebugPrint(GetMusicProgress())
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetMusicProgress)
function GetMusicProgress() end

--- @param progress? number -- Progress in seconds. Default 0.0.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
---  		SetMusicProgress(GetMusicProgress() - 1.0)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetMusicProgress)
function SetMusicProgress(progress) end

--- Override current music volume for this frame. Call continuously to keep overriding.
--- @param volume number -- Music volume.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputDown("interact") then
---  		SetMusicVolume(0.3)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetMusicVolume)
function SetMusicVolume(volume) end

--- Override current music low pass filter for this frame. Call continuously to keep overriding.
--- @param wet number -- Music low pass filter 0.0 - 1.0.
--- ### Example
--- ```lua
--- function client.init()
--- 	PlayMusic("about.ogg")
--- end
--- function client.tick()
--- 	if InputDown("interact") then
---  		SetMusicLowPass(0.6)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetMusicLowPass)
function SetMusicLowPass(wet) end

