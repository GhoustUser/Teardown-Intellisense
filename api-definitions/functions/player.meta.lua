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

--- @return number[] name -- List of all player Ids
--- ### Example
--- ```lua
--- local playerIds = GetAllPlayers()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAllPlayers)
function GetAllPlayers() end

--- @return integer count -- Number of max players for the session. Returns 1 for non-multiplayer.
--- ### Example
--- ```lua
--- local maxPlayerCount = GetMaxPlayers()
--- -- create an UI big enough to fit a the max player count
--- createGameModeUI(maxPlayerCount)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetMaxPlayers)
function GetMaxPlayers() end

--- @return number count -- Number of players
--- ### Example
--- ```lua
--- local playerCount = GetPlayerCount()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCount)
function GetPlayerCount() end

--- @return number[] playerIds -- List of added player Ids
--- ### Example
--- ```lua
--- local playerIds = GetAddedPlayers()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAddedPlayers)
function GetAddedPlayers() end

--- @return number[] playerIds -- List of removed player Ids
--- ### Example
--- ```lua
--- local playerIds = GetRemovedPlayers()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRemovedPlayers)
function GetRemovedPlayers() end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string name -- Player name
--- ### Example
--- ```lua
--- local name = GetPlayerName(0)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerName)
function GetPlayerName(playerId) end

--- @return number GetLocalPlayer -- Local player ID.
--- ### Example
--- ```lua
--- local p = GetLocalPlayer()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLocalPlayer)
function GetLocalPlayer() end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerLocal -- Whether a player is the local player.
--- ### Example
--- ```lua
--- if IsPlayerLocal(attacker) then
--- 	score = score + 1
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerLocal)
function IsPlayerLocal(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string character -- Character id
--- ### Example
--- ```lua
--- local character = GetPlayerCharacter(0)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCharacter)
function GetPlayerCharacter(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerHost -- Whether a player is the host
--- ### Example
--- ```lua
--- local isHost = IsPlayerHost()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerHost)
function IsPlayerHost(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean IsPlayerValid -- Whether a player is valid (existing player)
--- ### Example
--- ```lua
--- local isValid = IsPlayerValid(flagCarrier)
--- if not isValid then
--- 	dropFlag()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerValid)
function IsPlayerValid(playerId) end

--- Return center point of player. This function is deprecated.
--- Use GetPlayerTransform instead.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec position -- Player center position
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPos)
function GetPlayerPos(playerId) end

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
--- ### Example
--- ```lua
--- local muzzle = GetToolLocationWorldTransform("muzzle")
--- local _, pos, _, dir = GetPlayerAimInfo(muzzle.pos)
--- Shoot(pos, dir)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerAimInfo)
function GetPlayerAimInfo(position, maxdist, playerId) end

--- The player pitch angle is applied to the player camera transform. This value can be used to animate tool pitch movement when using SetToolTransformOverride.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number pitch -- Current player pitch angle
--- ### Example
--- ```lua
--- function client.init()
--- 	local pitchRotation = Quat(Vec(1,0,0), GetPlayerPitch())
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPitch)
function GetPlayerPitch(playerId) end

--- The player yaw angle is applied to the player camera transform. It represents the top-down angle of rotation of the player.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number yaw -- Current player yaw angle
--- ### Example
--- ```lua
--- function client.init()
--- 	local compassBearing = GetPlayerYaw()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerYaw)
function GetPlayerYaw(playerId) end

--- ### SERVER ONLY
--- Sets the player pitch.
--- @param pitch number -- Pitch.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	-- look straight ahead
--- 	SetPlayerPitch(0.0, playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerPitch)
function SetPlayerPitch(pitch, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number recoil -- Current player crouch
--- ### Example
--- ```lua
--- function client.tick()
--- 	local crouch = GetPlayerCrouch()
--- 	if crouch > 0.0 then
--- 		...
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCrouch)
function GetPlayerCrouch(playerId) end

--- The player transform is located at the bottom of the player. The player transform
--- considers heading (looking left and right). Forward is along negative Z axis.
--- Player pitch (looking up and down) does not affect player transform.
--- If you want the transform of the eye, use GetPlayerCameraTransform() instead.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player transform
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTransform)
function GetPlayerTransform(playerId) end

--- The player transform is located at the bottom of the player. Forward is along negative Z axis.
--- If you want the transform of the eye, use GetPlayerCameraTransform() instead.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return table transform -- Current player transform, including pitch (look up/down)
--- ### Example
--- ```lua
--- local t = GetPlayerTransform()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTransformWithPitch)
function GetPlayerTransformWithPitch(playerId) end

--- ### SERVER ONLY
--- Instantly teleport the player to desired transform, excluding pitch.
--- If you want to include pitch, use SetPlayerTransformWithPitch instead.
--- Player velocity will be reset to zero.
--- @param transform TTransform -- Desired player transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		local t = Transform(Vec(50, 0, 0), QuatEuler(0, 90, 0))
--- 		SetPlayerTransform(t, playerId)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTransform)
function SetPlayerTransform(transform, playerId) end

--- ### SERVER ONLY
--- Instantly teleport the player to desired transform, including pitch.
--- Player velocity will be reset to zero.
--- @param transform table -- Desired player transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- local t = Transform(Vec(10, 0, 0), QuatEuler(30, 90, 0))
--- SetPlayerTransform(t, playerId)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTransformWithPitch)
function SetPlayerTransformWithPitch(transform, playerId) end

--- ### SERVER ONLY
--- Make the ground act as a conveyor belt, pushing the player even if ground shape is static.
--- @param vel TVec -- Desired ground velocity
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	SetPlayerGroundVelocity(Vec(2,0,0), playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerGroundVelocity)
function SetPlayerGroundVelocity(vel, playerId) end

--- The player eye transform is the same as what you get from GetCameraTransform when playing in first-person,
--- but if you have set a camera transform manually with SetCameraTransform or playing in third-person, you can retrieve
--- the player eye transform with this function.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player eye transform
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerEyeTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerEyeTransform)
function GetPlayerEyeTransform(playerId) end

--- The player camera transform is usually the same as what you get from GetCameraTransform,
--- but if you have set a camera transform manually with SetCameraTransform, you can retrieve
--- the standard player camera transform with this function.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- Current player camera transform
--- ### Example
--- ```lua
--- function client.init()
--- 	local t = GetPlayerCameraTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCameraTransform)
function GetPlayerCameraTransform(playerId) end

--- ### CLIENT ONLY
--- Call this function continously to apply a camera offset. Can be used for camera effects
--- such as shake and wobble.
--- @param transform TTransform -- Desired player camera offset transform
--- @param stackable? boolean -- True if eye offset should summ up with multiple calls per tick
--- @param playerId? number -- Player ID. On client, zero means client player.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local t = Transform(Vec(), QuatAxisAngle(Vec(1, 0, 0), math.sin(GetTime()*3.0) * 3.0))
--- 	SetPlayerCameraOffsetTransform(t, playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerCameraOffsetTransform)
function SetPlayerCameraOffsetTransform(transform, stackable, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn transform.
--- @param transform TTransform -- Desired player spawn transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function setPlayerSpawnTransform(playerId)
--- 	local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
--- 	SetPlayerSpawnTransform(t, playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnTransform)
function SetPlayerSpawnTransform(transform, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn health amount.
--- @param health number -- Desired player spawn health (between zero and one)
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	SetPlayerSpawnHealth(0.5, playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnHealth)
function SetPlayerSpawnHealth(health, playerId) end

--- ### SERVER ONLY
--- Call this function during init to alter the player spawn active tool.
--- @param id string -- Tool unique identifier
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	SetPlayerSpawnTool("pistol", playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerSpawnTool)
function SetPlayerSpawnTool(id, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec velocity -- Player velocity in world space as vector
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vel = GetPlayerVelocity()
--- 	DebugPrint(VecStr(vel))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerVelocity)
function GetPlayerVelocity(playerId) end

--- ### SERVER ONLY
--- Drive specified vehicle.
--- @param vehicle number -- Handle to vehicle or zero to not drive.
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact", playerId) then
--- 		local car = FindVehicle("mycar")
--- 		SetPlayerVehicle(car, playerId)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerVehicle)
function SetPlayerVehicle(vehicle, playerId) end

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
--- ### Example
--- ```lua
--- local bodies = GetPlayerBodies(playerId)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerBodies)
function GetPlayerBodies(playerId) end

--- ### SERVER ONLY
--- @param velocity TVec -- Player velocity in world space as vector
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		SetPlayerVelocity(Vec(0, 5, 0), playerId)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerVelocity)
function SetPlayerVelocity(velocity, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Current vehicle handle, or zero if not in vehicle
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = GetPlayerVehicle()
--- 	if vehicle ~= 0 then
--- 		DebugPrint("Player drives the vehicle")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerVehicle)
function GetPlayerVehicle(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isGrounded -- Whether the player is grounded
--- ### Example
--- ```lua
--- local isGrounded = IsPlayerGrounded()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerGrounded)
function IsPlayerGrounded(playerId) end

--- @param handle number -- Vehicle handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isDriver -- Whether the player is driver for this vehicle
--- ### Example
--- ```lua
--- local vehicle = FindVehicle("myvehicle")
--- local isDriver = IsPlayerVehicleDriver(vehicle)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerVehicleDriver)
function IsPlayerVehicleDriver(handle, playerId) end

--- @param handle number -- Vehicle handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isPassenger -- Whether the player is a passenger of this vehicle
--- ### Example
--- ```lua
--- local vehicle = FindVehicle("myvehicle")
--- local isPassenger = IsPlayerVehiclePassenger(vehicle)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerVehiclePassenger)
function IsPlayerVehiclePassenger(handle, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean isGrounded -- Whether the player is jumping or not
--- ### Example
--- ```lua
--- local isJumping = IsPlayerJumping()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerJumping)
function IsPlayerJumping(playerId) end

--- Get information about player ground contact. If the output boolean (contact) is false then
--- the rest of the output is invalid.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean contact -- Whether the player is grounded
--- @return number shape -- Handle to shape
--- @return TVec point -- Point of contact
--- @return TVec normal -- Normal of contact
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGroundContact)
function GetPlayerGroundContact(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to grabbed shape or zero if not grabbing.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerGrabShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Player is grabbing a shape")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabShape)
function GetPlayerGrabShape(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to grabbed body or zero if not grabbing.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerGrabBody()
--- 	if body ~= 0 then
--- 		DebugPrint("Player is grabbing a body")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabBody)
function GetPlayerGrabBody(playerId) end

--- ### SERVER ONLY
--- Release what the player is currently holding
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("jump", playerId) then
--- 		ReleasePlayerGrab(playerId)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ReleasePlayerGrab)
function ReleasePlayerGrab(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec pos -- The world space grab point.
--- ### Example
--- ```lua
--- local body = GetPlayerGrabBody()
--- if body ~= 0 then
--- 	local pos = GetPlayerGrabPoint()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerGrabPoint)
function GetPlayerGrabPoint(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to picked shape or zero if nothing is picked
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerPickShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Picked shape " .. shape)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPickShape)
function GetPlayerPickShape(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to picked body or zero if nothing is picked
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerPickBody()
--- 	if body ~= 0 then
--- 		DebugWatch("Pick body ", body)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerPickBody)
function GetPlayerPickBody(playerId) end

--- Interactable shapes has to be tagged with "interact". The engine
--- determines which interactable shape is currently interactable.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interactable shape or zero
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = GetPlayerInteractShape()
--- 	if shape ~= 0 then
--- 		DebugPrint("Interact shape " .. shape)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerInteractShape)
function GetPlayerInteractShape(playerId) end

--- Interactable shapes has to be tagged with "interact". The engine
--- determines which interactable body is currently interactable.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interactable body or zero
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = GetPlayerInteractBody()
--- 	if body ~= 0 then
--- 		DebugPrint("Interact body " .. body)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerInteractBody)
function GetPlayerInteractBody(playerId) end

--- ### SERVER ONLY
--- Set the screen the player should interact with. For the screen
--- to feature a mouse pointer and receieve input, the screen also
--- needs to have interactive property.
--- @param handle number -- Handle to screen or zero for no screen
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerScreen)
function SetPlayerScreen(handle, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to interacted screen or zero if none
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerScreen)
function GetPlayerScreen(playerId) end

--- ### SERVER ONLY
--- @param health number -- Set player health (between zero and one)
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHealth)
function SetPlayerHealth(health, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number health -- Current player health
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerHealth)
function GetPlayerHealth(playerId) end

--- Will be false if player is in vehicle, interacting with a screen, has pause menu open, is dead or uses interactive UI.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean canusetool -- If the player currenty can use tool.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCanUseTool)
function GetPlayerCanUseTool(playerId) end

--- ### SERVER ONLY
--- Enable or disable regeneration for player
--- @param state boolean -- State of player regeneration
--- @param player? number -- Player ID change regeneration for
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	-- initially disable regeneration for player
--- 	SetPlayerRegenerationState(false, playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRegenerationState)
function SetPlayerRegenerationState(state, player) end

--- ### SERVER ONLY
--- @param toolId string -- Set Tool ID
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function playerJoined(playerId)
--- 	-- Server sets player tool to "gun"
--- 	SetPlayerTool("gun", playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerTool)
function SetPlayerTool(toolId, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string toolId -- Get Tool ID
--- ### Example
--- ```lua
--- local tool = GetPlayerTool()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerTool)
function GetPlayerTool(playerId) end

--- ### SERVER ONLY
--- Respawn player at spawn position without modifying the scene
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#RespawnPlayer)
function RespawnPlayer(playerId) end

--- ### SERVER ONLY
--- Respawn player at spawn position without modifying the scene
--- @param transform TVec -- Transform
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#RespawnPlayerAtTransform)
function RespawnPlayerAtTransform(transform, playerId) end

--- This function gets base speed, but real player speed depends on many
--- factors such as health, crouch, water, grabbing objects.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player base walking speed
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerWalkingSpeed())
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerWalkingSpeed)
function GetPlayerWalkingSpeed(playerId) end

--- ### SERVER ONLY
--- This function sets base speed, but real player speed depends on many
--- factors such as health, crouch, water, grabbing objects.
--- @param speed number -- Set player walking speed
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerWalkingSpeed)
function SetPlayerWalkingSpeed(speed, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player walking speed while crouched
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerCrouchSpeedScale())
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerCrouchSpeedScale)
function GetPlayerCrouchSpeedScale(playerId) end

--- ### SERVER ONLY
--- This function sets base speed the player is changed to while crouched
--- @param speed number -- Set player walking speed while crouched
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerCrouchSpeedScale)
function SetPlayerCrouchSpeedScale(speed, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number speed -- Current player walking speed when hurt
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(GetPlayerHurtSpeedScale())
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerHurtSpeedScale)
function GetPlayerHurtSpeedScale(playerId) end

--- ### SERVER ONLY
--- This function sets base speed the player is interpolated towards based on the health
--- @param speed number -- Set player walking speed when hurt
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function server.tick()
--- 	-- Reduce hurt penalty (default is 2/7 or roughly 0.29)
--- 	for p in Players() do
--- 		SetPlayerHurtSpeedScale(0.6, p)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHurtSpeedScale)
function SetPlayerHurtSpeedScale(speed, playerId) end

--- @param parameter GetPlayerParam_parameter -- Parameter name
--- @param player? number -- Player ID. On player, zero means local player.
--- @return any value -- Parameter value
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerParam)
function GetPlayerParam(parameter, player) end

--- ### SERVER ONLY
--- @param parameter SetPlayerParam_parameter -- Parameter name
--- @param value any -- Parameter value
--- @param player? number -- Player ID. On player, zero means local player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerParam)
function SetPlayerParam(parameter, value, player) end

--- Use this function to hide the player character.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- function client.tick()
--- 	...
--- 	SetCameraTransform(t)
--- 	SetPlayerHidden()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerHidden)
function SetPlayerHidden(playerId) end

--- ### SERVER ONLY
--- Register a custom tool that will show up in the player inventory and
--- can be selected with scroll wheel. Do this only once per tool.
--- You also need to enable the tool in the registry before it can be used.
--- @param id string -- Tool unique identifier
--- @param name string -- Tool name to show in hud
--- @param file string -- Path to vox file or prefab xml
--- @param group? number -- Tool group for this tool (1-6) Default is 6.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#RegisterTool)
function RegisterTool(id, name, file, group) end

--- ### SERVER ONLY
--- Sets the default amount of ammo granted when picking up an ammo crate
--- associated with a specific tool. This is useful if your mod provides
--- custom crates or ammo pickups for tools.
--- @param toolId string -- Tool ID
--- @param ammo number -- The default ammo pickup amount
--- ### Example
--- ```lua
--- function server.init()
--- 	RegisterTool("lasergun", "Laser Gun", "MOD/vox/lasergun.vox", 6)
--- 	SetToolAmmoPickupAmount("lasergun", 30)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAmmoPickupAmount)
function SetToolAmmoPickupAmount(toolId, ammo) end

--- @param toolId string -- Tool ID
--- @return number ammo -- The default ammo pickup amount
--- ### Example
--- ```lua
--- local ammo = GetToolAmmoPickupAmount("gun")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolAmmoPickupAmount)
function GetToolAmmoPickupAmount(toolId) end

--- Return body handle of the visible tool. You can use this to retrieve tool shapes
--- and animate them, change emissiveness, etc. Do not attempt to set the tool body
--- transform, since it is controlled by the engine. Use SetToolTranform for that.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle to currently visible tool body or zero if none
--- ### Example
--- ```lua
--- function client.tick()
--- 	local toolBody = GetToolBody()
--- 	if toolBody~=0 then
--- 		DebugPrint("Tool body: " .. toolBody)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolBody)
function GetToolBody(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform right -- Transform of right hand relative to the tool body origin, or nil if the right hand is not used
--- @return TTransform left -- Transform of left hand, or nil if left hand is not used
--- ### Example
--- ```lua
--- local right, left = GetToolHandPoseLocalTransform()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolHandPoseLocalTransform)
function GetToolHandPoseLocalTransform(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform right -- Transform of right hand in world space, or nil if the right hand is not used
--- @return TTransform left -- Transform of left hand, or nil if left hand is not used
--- ### Example
--- ```lua
--- local right, left = GetToolHandPoseWorldTransform()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolHandPoseWorldTransform)
function GetToolHandPoseWorldTransform(playerId) end

--- ### CLIENT ONLY
--- @param right TTransform -- Transform of right hand relative to the tool body origin, or nil if right hand is not used
--- @param left TTransform -- Transform of left hand, or nil if left hand is not used
--- @param playerId? number -- Player ID. On client, zero means client player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolHandPoseLocalTransform)
function SetToolHandPoseLocalTransform(right, left, playerId) end

--- Return transform of a tool location in tool space. Locations can be defined using the tool prefab editor.
--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform location -- Transform of a tool location in tool space or nil if location is not found.
--- ### Example
--- ```lua
--- local right  = GetToolLocationLocalTransform("righthand")
--- SetToolHandPoseLocalTransform(right, nil)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolLocationLocalTransform)
function GetToolLocationLocalTransform(name, playerId) end

--- Return transform of a tool location in world space. Locations can be defined using the tool prefab editor. A tool location is defined in tool space and to get the world space transform a tool body is required.
--- If a tool body does not exist this function will return nil.
--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform location -- Transform of a tool location in world space or nil if the location is not found or if there is no visible tool body.
--- ### Example
--- ```lua
--- local muzzle = GetToolLocationWorldTransform("muzzle")
--- Shoot(muzzle, direction)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolLocationWorldTransform)
function GetToolLocationWorldTransform(name, playerId) end

--- ### CLIENT ONLY
--- Apply an additional transform on the visible tool body. This can be used to
--- create tool animations. You need to set this every frame from the tick function.
--- The optional sway parameter control the amount of tool swaying when walking.
--- Set to zero to disable completely.
--- @param transform TTransform -- Tool body transform
--- @param sway? number -- Tool sway amount. Default is 1.0
--- @param playerId? number -- Player ID. On client, zero means client player.
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Offset the tool half a meter to the right for the local player
--- 	local offset = Transform(Vec(0.5, 0, 0))
--- 	SetToolTransform(offset)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolTransform)
function SetToolTransform(transform, sway, playerId) end

--- ### CLIENT ONLY
--- Set the allowed zoom for a registered tool. The zoom sensitivity will be factored
--- with the user options for sensitivity.
--- @param zoom number -- Zoom factor
--- @param zoomSensitivity? number -- Input sensitivity when zoomed in. Default is 1.0.
--- ### Example
--- ```lua
--- function client.tick()
--- 	-- allow our scoped tool to zoom by factor 4.
--- 	SetToolAllowedZoom(4.0, 0.5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAllowedZoom)
function SetToolAllowedZoom(zoom, zoomSensitivity) end

--- ### CLIENT ONLY
--- This function serves as an alternative to SetToolTransform, providing full control over tool animation by disabling all internal tool animations.
--- When using this function, you must manually include pitch, sway, and crouch movements in the transform. To maintain this control, call the function every frame from the tick function.
--- @param transform TTransform -- Tool body transform
--- @param playerId? number -- Player ID. On client, zero means client player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolTransformOverride)
function SetToolTransformOverride(transform, playerId) end

--- ### CLIENT ONLY
--- Apply an additional offset on the visible tool body. This can be used to
--- tweak tool placement for different characters. You need to set this every frame from the tick function.
--- @param offset TVec -- Tool body offset
--- @param playerId? number -- Player ID. On client, zero means client player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolOffset)
function SetToolOffset(offset, playerId) end

--- ### SERVER ONLY
--- @param toolId string -- Tool ID
--- @param ammo number -- Total ammo
--- @param playerId? number -- Player ID. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- SetToolAmmo("gun", 10, 1)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolAmmo)
function SetToolAmmo(toolId, ammo, playerId) end

--- @param toolId string -- Tool ID
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number ammo -- Total ammo for tool
--- ### Example
--- ```lua
--- local ammo = GetToolAmmo("gun", 1)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetToolAmmo)
function GetToolAmmo(toolId, playerId) end

--- ### SERVER ONLY
--- @param toolId string -- Tool ID
--- @param enabled boolean -- Tool enabled
--- @param playerId? number -- Player ID
--- ### Example
--- ```lua
--- SetToolEnabled("gun", false, playerId)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolEnabled)
function SetToolEnabled(toolId, enabled, playerId) end

--- @param toolId string -- Tool ID
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean enabled -- Tool enabled for player
--- ### Example
--- ```lua
--- if IsToolEnabled("gun", 1) then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsToolEnabled)
function IsToolEnabled(toolId, playerId) end

--- ### SERVER ONLY
--- Sets the base orientation when gravity is disabled with SetGravity.
--- This will determine what direction is "up", "right" and "forward" as
--- gravity is completely turned off.
--- @param orientation TQuat -- Base orientation
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerOrientation)
function SetPlayerOrientation(orientation, playerId) end

--- Gets the base orientation of the player.
--- This can be used to retrieve the base orientation of the player when using a custom gravity vector.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerOrientation)
function GetPlayerOrientation(playerId) end

--- This function returns the up vector of the player, which is determined by the player's base orientation.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TVec up -- Up vector of the player
--- ### Example
--- ```lua
--- function client.tick()
--- 	local up = GetPlayerUp()
--- 	DebugPrint("Player up vector: " .. up)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerUp)
function GetPlayerUp(playerId) end

--- @param rig number -- Rig handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- 	local rig = FindRig("myrig")
--- 	SetPlayerRig(rig)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRig)
function SetPlayerRig(rig, playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number rig -- Rig handle
--- ### Example
--- ```lua
--- local rig = GetPlayerRig(rigid)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRig)
function GetPlayerRig(playerId) end

--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return TTransform transform -- World transform, nil if player doesnt have a rig
--- ### Example
--- ```lua
--- local t = GetPlayerRigWorldTransform()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigWorldTransform)
function GetPlayerRigWorldTransform(playerId) end

--- @param rigId number -- Unique rig-id, -1 means all rigs
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- 	ClearPlayerRig(someId)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ClearPlayerRig)
function ClearPlayerRig(rigId, playerId) end

--- @param rigId number -- Unique id
--- @param name string -- Name of location
--- @param location table -- Rig Local transform of the location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- 	local someBody = FindBody("bodyname")
--- 	SetPlayerRigLocationLocalTransform(someBody, "ik_foot_l", TransformToLocalTransform(GetBodyTransform(someBody), GetLocationTransform(FindLocation("ik_foot_l"))))
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigLocationLocalTransform)
function SetPlayerRigLocationLocalTransform(rigId, name, location, playerId) end

--- @param rigId number -- Unique id
--- @param location table -- New world transform
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- 	local someBody = FindBody("bodyname")
--- 	SetPlayerRigTransform(someBody, GetBodyTransform(someBody))
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigTransform)
function SetPlayerRigTransform(rigId, location, playerId) end

--- @param name string -- Name of location
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return table location -- Transform of a location in world space
--- ### Example
--- ```lua
--- local t = GetPlayerRigLocationWorldTransform("ik_hand_l")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigLocationWorldTransform)
function GetPlayerRigLocationWorldTransform(name, playerId) end

--- ### CLIENT ONLY
--- @param rigId number -- Unique id
--- @param tag string -- Tag
--- @param playerId? number -- Player ID. On client, zero means client player.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerRigTags)
function SetPlayerRigTags(rigId, tag, playerId) end

--- @param tag string -- Tag name
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean exists -- Returns true if entity has tag
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerRigHasTag)
function GetPlayerRigHasTag(tag, playerId) end

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
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPlayerColor)
function GetPlayerColor(playerId) end

--- @param r number -- Red value
--- @param g number -- Green value
--- @param b number -- Blue value
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- end
--- function client.tick()
--- 	local r, g, b = 1.0, 0.5, 0.2
--- 	SetPlayerColor(r, g, b)
--- 	DebugPrint("Set player color to: " .. r .. ", " .. g .. ", " .. b)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPlayerColor)
function SetPlayerColor(r, g, b, playerId) end

--- ### SERVER ONLY
--- Apply damage to a player. Instigating player ID could be used to correctly
--- attribute the "score" to a player.
--- @param targetPlayerId number -- Target player ID
--- @param damage number -- Damage to apply to target player
--- @param cause? string -- The cause of damage
--- @param instigatingPlayerId? number -- Instigating player ID.
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
--- [View Documentation](https://teardowngame.com/experimental/api.html#ApplyPlayerDamage)
function ApplyPlayerDamage(targetPlayerId, damage, cause, instigatingPlayerId) end

--- ### SERVER ONLY
--- Disable input for a player. Should be called from tick.
--- @param player number -- Player to disable input for
--- ### Example
--- ```lua
--- -- Disable player 2 input as she/he is interacting with something.
--- DisablePlayerInput(2)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayerInput)
function DisablePlayerInput(player) end

--- ### SERVER ONLY
--- Disables the player from any interaction, physics and rendering.
--- @param playerId number -- Player to disable
--- ### Example
--- ```lua
--- function updateFinalScoreboard()
--- 	for i=1,#hiddenPlayers do
--- 		DisablePlayer(hiddenPlayers[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayer)
function DisablePlayer(playerId) end

--- Check if player is actively disabled
--- @param playerId number -- Check if player is disabled
--- ### Example
--- ```lua
--- --check if disabled
--- playerDisabled = IsPlayerDisabled(playerId)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPlayerDisabled)
function IsPlayerDisabled(playerId) end

--- ### SERVER ONLY
--- Disables the player from any incoming damage, such as explosions, gun shots, or drowning.
--- @param playerId number -- Player for which damage should be disabled
--- ### Example
--- ```lua
--- function server.tick()
--- 	for i=1,#invulnerablePlayers do
--- 		DisablePlayerDamage(invulnerablePlayers[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DisablePlayerDamage)
function DisablePlayerDamage(playerId) end

