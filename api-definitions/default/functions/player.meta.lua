--- @meta


--- @alias GetPlayerParam_parameter
--- | 'health' Current value of the player's health.
--- | 'healthRegeneration' Is the player's health regeneration enabled.
--- | 'walkingSpeed' The player's walking speed.
--- | 'jumpSpeed' The player's jump speed.
--- | 'godMode' If the value is True, the player does not lose health
--- | 'friction' Player body friction
--- | 'frictionMode' Player friction combine mode
--- | 'flyMode' If the value is True, the player will fly
--- | 'flashlightAllowed' Changes ability to use flashlight
--- | 'disableInteract' Disable interactions for player
--- | 'CollisionMask' Player collision mask bits (0-255) with respect to all shapes layer bits


--- @alias SetPlayerParam_parameter
--- | 'health' Current value of the player's health.
--- | 'healthRegeneration' Is the player's health regeneration enabled.
--- | 'walkingSpeed' The player's walking speed.
--- | 'jumpSpeed' The player's jump speed. The height of the jump depends non-linearly on the jump speed.
--- | 'godMode' If the value is True, the player does not lose health
--- | 'friction' Player body friction. Default is 0.8
--- | 'frictionMode' Player friction combine mode. Can be (average|minimum|multiply|maximum)
--- | 'flyMode' If the value is True, the player will fly
--- | 'flashlightAllowed' Changes ability to use flashlight
--- | 'disableInteract' Disable interactions for player
--- | 'CollisionMask' Player collision mask bits (0-255) with respect to all shapes layer bits


--- ### Example
--- ```lua
--- local playerIds = GetAllPlayers()
--- ```
--- @return number[] name -- List of all player Ids
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAllPlayers)
function GetAllPlayers() end

--- ### Example
--- ```lua
--- local maxPlayerCount = GetMaxPlayers()
--- -- create an UI big enough to fit a the max player count
--- createGameModeUI(maxPlayerCount)
--- ```
--- @return integer count -- Number of max players for the session. Returns 1 for non-multiplayer.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetMaxPlayers)
function GetMaxPlayers() end

--- ### Example
--- ```lua
--- local playerCount = GetPlayerCount()
--- ```
--- @return number count -- Number of players
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCount)
function GetPlayerCount() end

--- ### Example
--- ```lua
--- local playerIds = GetAddedPlayers()
--- ```
--- @return number[] playerIds -- List of added player Ids
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAddedPlayers)
function GetAddedPlayers() end

--- ### Example
--- ```lua
--- local playerIds = GetRemovedPlayers()
--- ```
--- @return number[] playerIds -- List of removed player Ids
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRemovedPlayers)
function GetRemovedPlayers() end

--- ### Example
--- ```lua
--- local name = GetPlayerName(0)
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string name -- Player name
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerName)
function GetPlayerName(playerId) end

--- ### Example
--- ```lua
--- local p = GetLocalPlayer()
--- ```
--- @return number GetLocalPlayer -- Local player ID.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLocalPlayer)
function GetLocalPlayer() end

--- ### Example
--- ```lua
--- if IsPlayerLocal(attacker) then
--- 	score = score + 1
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerLocal -- Whether a player is the local player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerLocal)
function IsPlayerLocal(playerId) end

--- ### Example
--- ```lua
--- local character = GetPlayerCharacter(0)
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string character -- Character id
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCharacter)
function GetPlayerCharacter(playerId) end

--- ### Example
--- ```lua
--- local isHost = IsPlayerHost()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerHost -- Whether a player is the host
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerHost)
function IsPlayerHost(playerId) end

--- ### Example
--- ```lua
--- local isValid = IsPlayerValid(flagCarrier)
--- if not isValid then
--- 	dropFlag()
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerValid -- Whether a player is valid (existing player)
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerValid)
function IsPlayerValid(playerId) end

--- # ⚠️ Deprecated
--- @deprecated
--- ### use `GetPlayerTransform` instead.
--- ---
--- Return center point of player.
--- ### Example
--- ```lua
--- function client.init()
--- 	local p = GetPlayerPos()
--- 	DebugPrint(p)
--- 	--This is equivalent to
--- 	p = VecAdd(GetPlayerTransform().pos, Vec(0,1,0))
--- 	DebugPrint(p)
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec position -- Player center position
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPos)
function GetPlayerPos(playerId) end

--- ### Example
--- ```lua
--- local muzzle = GetToolLocationWorldTransform("muzzle")
--- local _, pos, _, dir = GetPlayerAimInfo(muzzle.pos)
--- Shoot(pos, dir)
--- -- example with all return values:
--- local hit, startpos, endpos, direction, hitnormal, hitdist, hitentity, hitmaterial = GetPlayerAimInfo(muzzle.pos)
--- ```
--- @param position TVec -- Start position of the search
--- @param maxdist? number -- Max search distance
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean hit -- TRUE if hit, FALSE otherwise.
--- @return TVec startpos -- Player can modify start position when close to walls etc
--- @return TVec endpos -- Hit position
--- @return TVec direction -- Direction from start position to end position
--- @return TVec hitnormal -- Normal of the hitpoint
--- @return number hitdist -- Distance of the hit
--- @return number hitentity -- Handle of the entitiy being hit
--- @return number hitmaterial -- Name of the material being hit
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerAimInfo)
function GetPlayerAimInfo(position, maxdist, playerId) end

--- The player pitch angle is applied to the player camera transform. This value can be used to animate tool pitch movement when using SetToolTransformOverride.
--- ### Example
--- ```lua
--- function client.init()
--- 	local pitchRotation = Quat(Vec(1,0,0), GetPlayerPitch())
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number pitch -- Current player pitch angle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPitch)
function GetPlayerPitch(playerId) end

--- The player yaw angle is applied to the player camera transform. It represents the top-down angle of rotation of the player.
--- ### Example
--- ```lua
--- function client.init()
--- 	local compassBearing = GetPlayerYaw()
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number yaw -- Current player yaw angle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerYaw)
function GetPlayerYaw(playerId) end

--- ### SERVER ONLY
--- Sets the player pitch.
--- ### Example
--- ```lua
--- function server.tick()
--- 	-- look straight ahead
--- 	SetPlayerPitch(0.0, playerId)
--- end
--- ```
--- @param pitch number -- Pitch.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerPitch)
function SetPlayerPitch(pitch, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local crouch = GetPlayerCrouch()
--- 	if crouch > 0.0 then
--- 		...
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number recoil -- Current player crouch
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCrouch)
function GetPlayerCrouch(playerId) end

--- The player transform is located at the bottom of the player. The player transform
--- considers heading (looking left and right). Forward is along negative Z axis.
--- Player pitch (looking up and down) does not affect player transform.
--- If you want the transform of the eye, use GetPlayerCameraTransform() instead.
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTransform)
function GetPlayerTransform(playerId) end

--- The player transform is located at the bottom of the player. Forward is along negative Z axis.
--- If you want the transform of the eye, use GetPlayerCameraTransform() instead.
--- ### Example
--- ```lua
--- local t = GetPlayerTransform()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return table transform -- Current player transform, including pitch (look up/down)
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTransformWithPitch)
function GetPlayerTransformWithPitch(playerId) end

--- ### SERVER ONLY
--- Instantly teleport the player to desired transform, excluding pitch.
--- If you want to include pitch, use SetPlayerTransformWithPitch instead.
--- Player velocity will be reset to zero.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		local t = Transform(Vec(50, 0, 0), QuatEuler(0, 90, 0))
--- 		SetPlayerTransform(t, playerId)
--- 	end
--- end
--- ```
--- @param transform TTransform -- Desired player transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTransform)
function SetPlayerTransform(transform, playerId) end

--- ### SERVER ONLY
--- Instantly teleport the player to desired transform, including pitch.
--- Player velocity will be reset to zero.
--- ### Example
--- ```lua
--- local t = Transform(Vec(10, 0, 0), QuatEuler(30, 90, 0))
--- SetPlayerTransform(t, playerId)
--- ```
--- @param transform table -- Desired player transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTransformWithPitch)
function SetPlayerTransformWithPitch(transform, playerId) end

--- ### SERVER ONLY
--- Make the ground act as a conveyor belt, pushing the player even if ground shape is static.
--- ### Example
--- ```lua
--- function server.tick()
--- 	SetPlayerGroundVelocity(Vec(2,0,0), playerId)
--- end
--- ```
--- @param vel TVec -- Desired ground velocity
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerGroundVelocity)
function SetPlayerGroundVelocity(vel, playerId) end

--- The player eye transform is the same as what you get from GetCameraTransform when playing in first-person,
--- but if you have set a camera transform manually with SetCameraTransform or playing in third-person, you can retrieve
--- the player eye transform with this function.
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerEyeTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player eye transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerEyeTransform)
function GetPlayerEyeTransform(playerId) end

--- The player camera transform is usually the same as what you get from GetCameraTransform,
--- but if you have set a camera transform manually with SetCameraTransform, you can retrieve
--- the standard player camera transform with this function.
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerCameraTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player camera transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCameraTransform)
function GetPlayerCameraTransform(playerId) end

--- ### CLIENT ONLY
--- Call this function continously to apply a camera offset. Can be used for camera effects
--- such as shake and wobble.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local t = Transform(Vec(), QuatAxisAngle(Vec(1, 0, 0), math.sin(GetTime()*3.0) * 3.0))
--- 	SetPlayerCameraOffsetTransform(t, playerId)
--- end
--- ```
--- @param transform TTransform -- Desired player camera offset transform
--- @param stackable? boolean -- True if eye offset should summ up with multiple calls per tick
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerCameraOffsetTransform)
function SetPlayerCameraOffsetTransform(transform, stackable, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn transform.
--- ### Example
--- ```lua
--- function setPlayerSpawnTransform(playerId)
--- 	local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
--- 	SetPlayerSpawnTransform(t, playerId)
--- end
--- ```
--- @param transform TTransform -- Desired player spawn transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnTransform)
function SetPlayerSpawnTransform(transform, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn health amount.
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	SetPlayerSpawnHealth(0.5, playerId)
--- end
--- ```
--- @param health number -- Desired player spawn health (between zero and one)
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnHealth)
function SetPlayerSpawnHealth(health, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn active tool.
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	SetPlayerSpawnTool("pistol", playerId)
--- end
--- ```
--- @param id string -- Tool unique identifier
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnTool)
function SetPlayerSpawnTool(id, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local vel = GetPlayerVelocity()
--- 	DebugPrint(VecStr(vel))
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec velocity -- Player velocity in world space as vector
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerVelocity)
function GetPlayerVelocity(playerId) end

--- ### SERVER ONLY
--- Drive specified vehicle.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		local car = FindVehicle("mycar")
--- 		SetPlayerVehicle(car, playerId)
--- 	end
--- end
--- ```
--- @param vehicle number -- Handle to vehicle or zero to not drive.
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerVehicle)
function SetPlayerVehicle(vehicle, playerId) end

--- ### Example
--- ```lua
--- local bodies = GetPlayerBodies(playerId)
--- ```
--- @param animator number -- Handle to animator or zero for no animator
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerAnimator)
function SetPlayerAnimator(animator, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number animator -- Handle to animator or zero for no animator
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerAnimator)
function GetPlayerAnimator(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number[] bodies -- Get bodies associated with a player
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerBodies)
function GetPlayerBodies(playerId) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		SetPlayerVelocity(Vec(0, 5, 0), playerId)
--- 	end
--- end
--- ```
--- @param velocity TVec -- Player velocity in world space as vector
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerVelocity)
function SetPlayerVelocity(velocity, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = GetPlayerVehicle()
--- 	if vehicle ~= 0 then
--- 		DebugPrint("Player drives the vehicle")
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Current vehicle handle, or zero if not in vehicle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerVehicle)
function GetPlayerVehicle(playerId) end

--- ### Example
--- ```lua
--- local isGrounded = IsPlayerGrounded()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isGrounded -- Whether the player is grounded
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerGrounded)
function IsPlayerGrounded(playerId) end

--- ### Example
--- ```lua
--- local vehicle = FindVehicle("myvehicle")
--- local isDriver = IsPlayerVehicleDriver(vehicle)
--- ```
--- @param handle number -- Vehicle handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isDriver -- Whether the player is driver for this vehicle
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerVehicleDriver)
function IsPlayerVehicleDriver(handle, playerId) end

--- ### Example
--- ```lua
--- local vehicle = FindVehicle("myvehicle")
--- local isPassenger = IsPlayerVehiclePassenger(vehicle)
--- ```
--- @param handle number -- Vehicle handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isPassenger -- Whether the player is a passenger of this vehicle
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerVehiclePassenger)
function IsPlayerVehiclePassenger(handle, playerId) end

--- ### Example
--- ```lua
--- local isJumping = IsPlayerJumping()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isGrounded -- Whether the player is jumping or not
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerJumping)
function IsPlayerJumping(playerId) end

--- Get information about player ground contact. If the output boolean (contact) is false then
--- the rest of the output is invalid.
--- ### Example
--- ```lua
--- function client.tick()
--- 	hasGroundContact, shape, point, normal = GetPlayerGroundContact()
--- 	if hasGroundContact then
--- 		-- print ground contact data
--- 		DebugPrint(VecStr(point).." : "..VecStr(normal))
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean contact -- Whether the player is grounded
--- @return number shape -- Handle to shape
--- @return TVec point -- Point of contact
--- @return TVec normal -- Normal of contact
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGroundContact)
function GetPlayerGroundContact(playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerGrabShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Player is grabbing a shape")
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to grabbed shape or zero if not grabbing.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabShape)
function GetPlayerGrabShape(playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerGrabBody()
--- 	if body ~= 0 then
--- 		DebugPrint("Player is grabbing a body")
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to grabbed body or zero if not grabbing.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabBody)
function GetPlayerGrabBody(playerId) end

--- ### SERVER ONLY
--- Release what the player is currently holding
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		ReleasePlayerGrab(playerId)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#ReleasePlayerGrab)
function ReleasePlayerGrab(playerId) end

--- ### Example
--- ```lua
--- local body = GetPlayerGrabBody()
--- if body ~= 0 then
--- 	local pos = GetPlayerGrabPoint()
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec pos -- The world space grab point.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabPoint)
function GetPlayerGrabPoint(playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerPickShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Picked shape " .. shape)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to picked shape or zero if nothing is picked
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPickShape)
function GetPlayerPickShape(playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerPickBody()
--- 	if body ~= 0 then
--- 		DebugWatch("Pick body ", body)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to picked body or zero if nothing is picked
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPickBody)
function GetPlayerPickBody(playerId) end

--- Interactable shapes has to be tagged with "interact". The engine
--- determines which interactable shape is currently interactable.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerInteractShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Interact shape " .. shape)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interactable shape or zero
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerInteractShape)
function GetPlayerInteractShape(playerId) end

--- Interactable shapes has to be tagged with "interact". The engine
--- determines which interactable body is currently interactable.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerInteractBody()
--- 	if body ~= 0 then
--- 		DebugPrint("Interact body " .. body)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interactable body or zero
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerInteractBody)
function GetPlayerInteractBody(playerId) end

--- ### SERVER ONLY
--- Set the screen the player should interact with. For the screen
--- to feature a mouse pointer and receieve input, the screen also
--- needs to have interactive property.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		if GetPlayerScreen(playerId) ~= 0 then
--- 			SetPlayerScreen(0, playerId)
--- 		else
--- 			SetPlayerScreen(screen, playerId)
--- 		end
--- 	end
--- end
--- ```
--- @param handle number -- Handle to screen or zero for no screen
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerScreen)
function SetPlayerScreen(handle, playerId) end

--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		if GetPlayerScreen(playerId) ~= 0 then
--- 			SetPlayerScreen(0, playerId)
--- 		else
--- 			SetPlayerScreen(screen, playerId)
--- 		end
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interacted screen or zero if none
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerScreen)
function GetPlayerScreen(playerId) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		if GetPlayerHealth() < 0.75 then
--- 			SetPlayerHealth(1.0, playerId)
--- 		else
--- 			SetPlayerHealth(0.5, playerId)
--- 		end
--- 	end
--- end
--- ```
--- @param health number -- Set player health (between zero and one)
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHealth)
function SetPlayerHealth(health, playerId) end

--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		if GetPlayerHealth() < 0.75 then
--- 			SetPlayerHealth(1.0, playerId)
--- 		else
--- 			SetPlayerHealth(0.5, playerId)
--- 		end
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number health -- Current player health
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerHealth)
function GetPlayerHealth(playerId) end

--- Will be false if player is in vehicle, interacting with a screen, has pause menu open, is dead or uses interactive UI.
--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		if GetPlayerCanUseTool(p) and InputPressed("usetool", p) then
--- 			-- fire laser
--- 		end
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean canusetool -- If the player currenty can use tool.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCanUseTool)
function GetPlayerCanUseTool(playerId) end

--- ### SERVER ONLY
--- Enable or disable regeneration for player
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	-- initially disable regeneration for player
--- 	SetPlayerRegenerationState(false, playerId)
--- end
--- ```
--- @param state boolean -- State of player regeneration
--- @param player? number -- Player ID change regeneration for
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRegenerationState)
function SetPlayerRegenerationState(state, player) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	-- Server sets player tool to "gun"
--- 	SetPlayerTool("gun", playerId)
--- end
--- ```
--- @param toolId string -- Set Tool ID
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTool)
function SetPlayerTool(toolId, playerId) end

--- ### Example
--- ```lua
--- local tool = GetPlayerTool()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string toolId -- Get Tool ID
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTool)
function GetPlayerTool(playerId) end

--- ### SERVER ONLY
--- Respawn player at spawn position without modifying the scene
--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		if InputPressed("interact", p) then
--- 			RespawnPlayer(p)
--- 		end
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#RespawnPlayer)
function RespawnPlayer(playerId) end

--- ### SERVER ONLY
--- Respawn player at spawn position without modifying the scene
--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		if InputPressed("interact", p) then
--- 			RespawnPlayerAtTransform(Transform(Vec(1,2,3)), p)
--- 		end
--- 	end
--- end
--- ```
--- @param transform TVec -- Transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#RespawnPlayerAtTransform)
function RespawnPlayerAtTransform(transform, playerId) end

--- This function gets base speed, but real player speed depends on many
--- factors such as health, crouch, water, grabbing objects.
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerWalkingSpeed())
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player base walking speed
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerWalkingSpeed)
function GetPlayerWalkingSpeed(playerId) end

--- ### SERVER ONLY
--- This function sets base speed, but real player speed depends on many
--- factors such as health, crouch, water, grabbing objects.
--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		-- Set player walking speed based on whether shift is pressed
--- 		if InputDown("shift", p) then
--- 			SetPlayerWalkingSpeed(15.0, p)
--- 		else
--- 			SetPlayerWalkingSpeed(7.0, p)
--- 		end
--- 	end
--- end
--- ```
--- @param speed number -- Set player walking speed
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerWalkingSpeed)
function SetPlayerWalkingSpeed(speed, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerCrouchSpeedScale())
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player walking speed while crouched
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCrouchSpeedScale)
function GetPlayerCrouchSpeedScale(playerId) end

--- ### SERVER ONLY
--- This function sets base speed the player is changed to while crouched
--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		if InputDown("shift") then
--- 			SetPlayerCrouchSpeedScale(5.0, p)
--- 		else
--- 			SetPlayerCrouchSpeedScale(3.0, p)
--- 		end
--- 	end
--- end
--- ```
--- @param speed number -- Set player walking speed while crouched
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerCrouchSpeedScale)
function SetPlayerCrouchSpeedScale(speed, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerHurtSpeedScale())
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player walking speed when hurt
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerHurtSpeedScale)
function GetPlayerHurtSpeedScale(playerId) end

--- ### SERVER ONLY
--- This function sets base speed the player is interpolated towards based on the health
--- ### Example
--- ```lua
--- function server.tick()
--- 	-- Reduce hurt penalty (default is 2/7 or roughly 0.29)
--- 	for p in Players() do
--- 		SetPlayerHurtSpeedScale(0.6, p)
--- 	end
--- end
--- ```
--- @param speed number -- Set player walking speed when hurt
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHurtSpeedScale)
function SetPlayerHurtSpeedScale(speed, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	-- The parameter names are case-insensitive, so any of the specified writing styles will be correct:
--- 	-- "GodMode", "godmode", "godMode"
--- 	local paramName = "GodMode"
--- 	local param = GetPlayerParam(paramName)
--- 	DebugWatch(paramName, param)
--- end
--- ```
--- @param parameter GetPlayerParam_parameter -- Parameter name
--- @param player? number -- Player ID. On player, zero means local player.
--- @return any value -- Parameter value
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerParam)
function GetPlayerParam(parameter, player) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.tick()
--- 	-- The parameter names are case-insensitive, so any of the specified writing styles will be correct:
--- 	-- "JumpSpeed", "jumpspeed", "jumpSpeed"
--- 	local paramName = "JumpSpeed"
--- 	for p in Players() do
--- 		-- Set player jump speed based on whether shift is pressed
--- 		if InputDown("shift", p) then
--- 			SetPlayerParam(paramName, 10, p)
--- 		else
--- 			SetPlayerParam(paramName, 5, p)
--- 		end
--- 	end
--- end
--- ```
--- @param parameter SetPlayerParam_parameter -- Parameter name
--- @param value any -- Parameter value
--- @param player? number -- Player ID. On player, zero means local player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerParam)
function SetPlayerParam(parameter, value, player) end

--- Use this function to hide the player character.
--- ### Example
--- ```lua
--- function client.tick()
--- 	...
--- 	SetCameraTransform(t)
--- 	SetPlayerHidden()
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHidden)
function SetPlayerHidden(playerId) end

--- ### SERVER ONLY
--- Register a custom tool that will show up in the player inventory and
--- can be selected with scroll wheel. Do this only once per tool.
--- You also need to enable the tool in the registry before it can be used.
--- ### Example
--- ```lua
--- function server.init()
--- 	RegisterTool("lasergun", "Laser Gun", "MOD/vox/lasergun.vox", 6)
--- end
--- function server.tick()
--- 	for p in Players() do
--- 		if GetPlayerTool(p) == "lasergun" then
--- 			--Tool is selected. Tool logic goes here.
--- 			if InputPressed("usetool", p) then
--- 				-- Fire the tool
--- 			end
--- 		end
--- 	end
--- end
--- function client.tick()
--- 	for p in Players() do
--- 		if GetPlayerTool(p) == "lasergun" then
--- 			if InputPressed("usetool", p) then
--- 				-- Spawn client side particles, play sound, etc.
--- 			end
--- 		end
--- 	end
--- end
--- ```
--- @param id string -- Tool unique identifier
--- @param name string -- Tool name to show in hud
--- @param file string -- Path to vox file or prefab xml
--- @param group? number -- Tool group for this tool (1-6) Default is 6.
--- [View Documentation](https://teardowngame.com/experimental/api.html#RegisterTool)
function RegisterTool(id, name, file, group) end

--- ### SERVER ONLY
--- Sets the default amount of ammo granted when picking up an ammo crate
--- associated with a specific tool. This is useful if your mod provides
--- custom crates or ammo pickups for tools.
--- ### Example
--- ```lua
--- function server.init()
--- 	RegisterTool("lasergun", "Laser Gun", "MOD/vox/lasergun.vox", 6)
--- 	SetToolAmmoPickupAmount("lasergun", 30)
--- end
--- ```
--- @param toolId string -- Tool ID
--- @param ammo number -- The default ammo pickup amount
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAmmoPickupAmount)
function SetToolAmmoPickupAmount(toolId, ammo) end

--- ### Example
--- ```lua
--- local ammo = GetToolAmmoPickupAmount("gun")
--- ```
--- @param toolId string -- Tool ID
--- @return number ammo -- The default ammo pickup amount
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolAmmoPickupAmount)
function GetToolAmmoPickupAmount(toolId) end

--- Return body handle of the visible tool. You can use this to retrieve tool shapes
--- and animate them, change emissiveness, etc. Do not attempt to set the tool body
--- transform, since it is controlled by the engine. Use SetToolTranform for that.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local toolBody = GetToolBody()
--- 	if toolBody~=0 then
--- 		DebugPrint("Tool body: " .. toolBody)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to currently visible tool body or zero if none
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolBody)
function GetToolBody(playerId) end

--- ### Example
--- ```lua
--- local right, left = GetToolHandPoseLocalTransform()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform right -- Transform of right hand relative to the tool body origin, or nil if the right hand is not used
--- @return TTransform left -- Transform of left hand, or nil if left hand is not used
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolHandPoseLocalTransform)
function GetToolHandPoseLocalTransform(playerId) end

--- ### Example
--- ```lua
--- local right, left = GetToolHandPoseWorldTransform()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform right -- Transform of right hand in world space, or nil if the right hand is not used
--- @return TTransform left -- Transform of left hand, or nil if left hand is not used
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolHandPoseWorldTransform)
function GetToolHandPoseWorldTransform(playerId) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- if GetBool("game.thirdperson") then
--- 	if aiming then
--- 		SetToolHandPoseLocalTransform(Transform(Vec(0.2,0.0,0.0), QuatAxisAngle(Vec(0,1,0), 90.0)), Transform(Vec(-0.1, 0.0, -0.4)))
--- 	else
--- 		SetToolHandPoseLocalTransform(Transform(Vec(0.2,0.0,0.0), QuatAxisAngle(Vec(0,1,0), 90.0)), nil)
--- 	end
--- end
--- ```
--- @param right TTransform | nil -- Transform of right hand relative to the tool body origin, or nil if right hand is not used
--- @param left TTransform | nil -- Transform of left hand, or nil if left hand is not used
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolHandPoseLocalTransform)
function SetToolHandPoseLocalTransform(right, left, playerId) end

--- Return transform of a tool location in tool space. Locations can be defined using the tool prefab editor.
--- ### Example
--- ```lua
--- local right  = GetToolLocationLocalTransform("righthand")
--- SetToolHandPoseLocalTransform(right, nil)
--- ```
--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform location -- Transform of a tool location in tool space or nil if location is not found.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolLocationLocalTransform)
function GetToolLocationLocalTransform(name, playerId) end

--- Return transform of a tool location in world space. Locations can be defined using the tool prefab editor. A tool location is defined in tool space and to get the world space transform a tool body is required.
--- If a tool body does not exist this function will return nil.
--- ### Example
--- ```lua
--- local muzzle = GetToolLocationWorldTransform("muzzle")
--- Shoot(muzzle, direction)
--- ```
--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform location -- Transform of a tool location in world space or nil if the location is not found or if there is no visible tool body.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolLocationWorldTransform)
function GetToolLocationWorldTransform(name, playerId) end

--- ### CLIENT ONLY
--- Apply an additional transform on the visible tool body. This can be used to
--- create tool animations. You need to set this every frame from the tick function.
--- The optional sway parameter control the amount of tool swaying when walking.
--- Set to zero to disable completely.
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Offset the tool half a meter to the right for the local player
--- 	local offset = Transform(Vec(0.5, 0, 0))
--- 	SetToolTransform(offset)
--- end
--- ```
--- @param transform TTransform -- Tool body transform
--- @param sway? number -- Tool sway amount. Default is 1.0
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolTransform)
function SetToolTransform(transform, sway, playerId) end

--- ### CLIENT ONLY
--- Set the allowed zoom for a registered tool. The zoom sensitivity will be factored
--- with the user options for sensitivity.
--- ### Example
--- ```lua
--- function client.tick()
--- 	-- allow our scoped tool to zoom by factor 4.
--- 	SetToolAllowedZoom(4.0, 0.5)
--- end
--- ```
--- @param zoom number -- Zoom factor
--- @param zoomSensitivity? number -- Input sensitivity when zoomed in. Default is 1.0.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAllowedZoom)
function SetToolAllowedZoom(zoom, zoomSensitivity) end

--- ### CLIENT ONLY
--- This function serves as an alternative to SetToolTransform, providing full control over tool animation by disabling all internal tool animations.
--- When using this function, you must manually include pitch, sway, and crouch movements in the transform. To maintain this control, call the function every frame from the tick function.
--- ### Example
--- ```lua
--- function client.tick()
--- 	if GetBool("game.thirdperson") then
--- 		local toolTransform = Transform(Vec(0.3, -0.3, -0.2), Quat(0.0, 0.0, 15.0))
--- 		-- Rotate around point
--- 		local pivotPoint = Vec(-0.01, -0.2, 0.04)
--- 		toolTransform.pos = VecSub(toolTransform.pos, pivotPoint)
--- 		local rotation = Transform(Vec(), QuatAxisAngle(Vec(0,0,1), GetPlayerPitch()))
--- 		toolTransform = TransformToParentTransform(rotation, toolTransform)
--- 		toolTransform.pos = VecAdd(toolTransform.pos, pivotPoint)
--- 		SetToolTransformOverride(toolTransform)
--- 	else
--- 		local toolTransform = Transform(Vec(0.3, -0.3, -0.2), Quat(0.0, 0.0, 15.0))
--- 		SetToolTransform(toolTransform)
--- 	end
--- end
--- ```
--- @param transform TTransform -- Tool body transform
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolTransformOverride)
function SetToolTransformOverride(transform, playerId) end

--- ### CLIENT ONLY
--- Apply an additional offset on the visible tool body. This can be used to
--- tweak tool placement for different characters. You need to set this every frame from the tick function.
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Offset the tool depending on character height
--- 	local defaultEyeY = 1.7
--- 	local offsetY = characterHeight - defaultEyeY
--- 	local offset = Vec(0, offsetY, 0)
--- 	SetToolOffset(offset)
--- end
--- ```
--- @param offset TVec -- Tool body offset
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolOffset)
function SetToolOffset(offset, playerId) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- SetToolAmmo("gun", 10, 1)
--- ```
--- @param toolId string -- Tool ID
--- @param ammo number -- Total ammo
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAmmo)
function SetToolAmmo(toolId, ammo, playerId) end

--- ### Example
--- ```lua
--- local ammo = GetToolAmmo("gun", 1)
--- ```
--- @param toolId string -- Tool ID
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number ammo -- Total ammo for tool
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolAmmo)
function GetToolAmmo(toolId, playerId) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- SetToolEnabled("gun", false, playerId)
--- ```
--- @param toolId string -- Tool ID
--- @param enabled boolean -- Tool enabled
--- @param playerId? number -- Player ID
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolEnabled)
function SetToolEnabled(toolId, enabled, playerId) end

--- ### Example
--- ```lua
--- if IsToolEnabled("gun", 1) then
--- 	...
--- end
--- ```
--- @param toolId string -- Tool ID
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean enabled -- Tool enabled for player
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsToolEnabled)
function IsToolEnabled(toolId, playerId) end

--- ### SERVER ONLY
--- Sets the base orientation when gravity is disabled with SetGravity.
--- This will determine what direction is "up", "right" and "forward" as
--- gravity is completely turned off.
--- ### Example
--- ```lua
--- function server.tick()
--- 	SetGravity(Vec(0, 0, 0))
--- 	-- Turn players upside-down.
--- 	for p in Players() do
--- 		SetPlayerOrientation(QuatAxisAngle(Vec(1,0,0), 180), p)
--- 	end
--- end
--- ```
--- @param orientation TQuat -- Base orientation
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerOrientation)
function SetPlayerOrientation(orientation, playerId) end

--- Gets the base orientation of the player.
--- This can be used to retrieve the base orientation of the player when using a custom gravity vector.
--- ### Example
--- ```lua
--- function server.tick(dt)
--- 	SetGravity(Vec(0, 0, 0))
--- 	for p in Players() do
--- 		-- Spin the player if using zero gravity
--- 		local base = QuatRotateQuat(GetPlayerOrientation(p), QuatAxisAngle(Vec(1,0,0), dt))
--- 		SetPlayerOrientation(base, p)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerOrientation)
function GetPlayerOrientation(playerId) end

--- This function returns the up vector of the player, which is determined by the player's base orientation.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local up = GetPlayerUp()
--- 	DebugPrint("Player up vector: " .. up)
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec up -- Up vector of the player
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerUp)
function GetPlayerUp(playerId) end

--- ### Example
--- ```lua
--- local rig = FindRig("myrig")
--- SetPlayerRig(rig)
--- ```
--- @param rig number -- Rig handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRig)
function SetPlayerRig(rig, playerId) end

--- ### Example
--- ```lua
--- local rig = GetPlayerRig(rigid)
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number rig -- Rig handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRig)
function GetPlayerRig(playerId) end

--- ### Example
--- ```lua
--- local t = GetPlayerRigWorldTransform()
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- World transform, nil if player doesnt have a rig
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigWorldTransform)
function GetPlayerRigWorldTransform(playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- ### Example
--- ```lua
--- ClearPlayerRig(someId)
--- ```
--- @param rigId number -- Unique rig-id, -1 means all rigs
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#ClearPlayerRig)
function ClearPlayerRig(rigId, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- ### Example
--- ```lua
--- local someBody = FindBody("bodyname")
--- SetPlayerRigLocationLocalTransform(
--- 	someBody,
--- 	"ik_foot_l",
--- 	TransformToLocalTransform(
--- 		GetBodyTransform(someBody),
--- 		GetLocationTransform(FindLocation("ik_foot_l"))
--- 	)
--- )
--- ```
--- @param rigId number -- Unique id
--- @param name string -- Name of location
--- @param location table -- Rig Local transform of the location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigLocationLocalTransform)
function SetPlayerRigLocationLocalTransform(rigId, name, location, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- ### Example
--- ```lua
--- local someBody = FindBody("bodyname")
--- SetPlayerRigTransform(someBody, GetBodyTransform(someBody))
--- ```
--- @param rigId number -- Unique id
--- @param location table -- New world transform
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigTransform)
function SetPlayerRigTransform(rigId, location, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- ### Example
--- ```lua
--- local t = GetPlayerRigLocationWorldTransform("ik_hand_l")
--- ```
--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return table location -- Transform of a location in world space
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigLocationWorldTransform)
function GetPlayerRigLocationWorldTransform(name, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- function client.tick()
--- 	local inuse, r, g, b = GetPlayerColor()
--- 	if inuse then
--- 		DebugPrint("Player color: " .. r .. ", " .. g .. ", " .. b)
--- 	else
--- 		DebugPrint("Player color is not set")
--- 	end
--- end
--- ```
--- @param rigId number -- Unique id
--- @param tag string -- Tag
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigTags)
function SetPlayerRigTags(rigId, tag, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- @param tag string -- Tag name
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean exists -- Returns true if entity has tag
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigHasTag)
function GetPlayerRigHasTag(tag, playerId) end

--- ### ⚠️ This function will be deprecated in the next update!
--- ---
--- @param tag string -- Tag name
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string value -- Returns the tag value, if any. Empty string otherwise.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigTagValue)
function GetPlayerRigTagValue(tag, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean inuse -- If color is used or not
--- @return number r -- Red channel value
--- @return number g -- Green channel value
--- @return number b -- Blue channel value
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerColor)
function GetPlayerColor(playerId) end

--- ### Example
--- ```lua
--- end
--- function client.tick()
--- 	local r, g, b = 1.0, 0.5, 0.2
--- 	SetPlayerColor(r, g, b)
--- 	DebugPrint("Set player color to: " .. r .. ", " .. g .. ", " .. b)
--- end
--- ```
--- @param r number -- Red value
--- @param g number -- Green value
--- @param b number -- Blue value
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerColor)
function SetPlayerColor(r, g, b, playerId) end

--- ### SERVER ONLY
--- Apply damage to a player. Instigating player ID could be used to correctly
--- attribute the "score" to a player.
--- ### Example
--- ```lua
--- function server.tick(dt)
--- 	for player in Players() do
--- 		if isOnFire(player) then
--- 			-- Apply 20% of dt as damage to the player
--- 			ApplyPlayerDamage(player, 0.2 * dt, "fire")
--- 		end
--- 	end
--- 	-- or
--- 	for player in Players() do
--- 		if InputIsPressed("usetool", player) then
--- 			for target in Players() do
--- 				if target ~= player and isInRange(player, target) then
--- 					-- Apply 50% damage to the target player
--- 					ApplyPlayerDamage(target, 0.5, "tool", player)
--- 				end
--- 			end
--- 		end
--- 	end
--- end
--- ```
--- @param targetPlayerId number -- Target player ID
--- @param damage number -- Damage to apply to target player
--- @param cause? string -- The cause of damage
--- @param instigatingPlayerId? number -- Instigating player ID.
--- [View Documentation](https://teardowngame.com/experimental/api.html#ApplyPlayerDamage)
function ApplyPlayerDamage(targetPlayerId, damage, cause, instigatingPlayerId) end

--- ### SERVER ONLY
--- Disable input for a player. Should be called from tick.
--- ### Example
--- ```lua
--- -- Disable player 2 input as she/he is interacting with something.
--- DisablePlayerInput(2)
--- ```
--- @param player number -- Player to disable input for
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayerInput)
function DisablePlayerInput(player) end

--- ### SERVER ONLY
--- Disables the player from any interaction, physics and rendering.
--- ### Example
--- ```lua
--- function updateFinalScoreboard()
--- 	for i=1,#hiddenPlayers do
--- 		DisablePlayer(hiddenPlayers[i])
--- 	end
--- end
--- ```
--- @param playerId number -- Player to disable
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayer)
function DisablePlayer(playerId) end

--- Check if player is actively disabled
--- ### Example
--- ```lua
--- --check if disabled
--- playerDisabled = IsPlayerDisabled(playerId)
--- ```
--- @param playerId number -- Check if player is disabled
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerDisabled)
function IsPlayerDisabled(playerId) end

--- ### SERVER ONLY
--- Disables the player from any incoming damage, such as explosions, gun shots, or drowning.
--- ### Example
--- ```lua
--- function server.tick()
--- 	for i=1,#invulnerablePlayers do
--- 		DisablePlayerDamage(invulnerablePlayers[i])
--- 	end
--- end
--- ```
--- @param playerId number -- Player for which damage should be disabled
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayerDamage)
function DisablePlayerDamage(playerId) end

