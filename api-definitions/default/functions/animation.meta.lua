--- @meta


--- ### Example
--- ```lua
--- SetAnimatorPositionIK(animator, "shoulder_l", "hand_l", Vec(10, 0, 0), 1.0, 0.9, true)
--- ```
--- @param handle number -- Animator handle
--- @param begname string -- Name of the start-bone of the chain
--- @param endname string -- Name of the end-bone of the chain
--- @param target TVec -- World target position that the "endname" bone should reach
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param history? number -- How much of the previous frames result [0,1] that should be used when start the IK search, default is 0.0
--- @param flag? boolean -- TRUE if constraints should be used, default is TRUE
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimatorPositionIK)
function SetAnimatorPositionIK(handle, begname, endname, target, weight, history, flag) end

--- ### Example
--- ```lua
--- SetAnimatorTransformIK(animator, "shoulder_l", "hand_l", Transform(10, 0, 0), 1.0, 0.9, false, true)
--- ```
--- @param handle number -- Animator handle
--- @param begname string -- Name of the start-bone of the chain
--- @param endname string -- Name of the end-bone of the chain
--- @param transform TTransform -- World target transform that the "endname" bone should reach
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param history? number -- How much of the previous frames result [0,1] that should be used when start the IK search, default is 0.0
--- @param locktarget? boolean -- TRUE if the end-bone should be fixed to the target-transform, FALSE if IK solution is used
--- @param useconstraints? boolean -- TRUE if constraints should be used, default is TRUE
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimatorTransformIK)
function SetAnimatorTransformIK(handle, begname, endname, transform, weight, history, locktarget, useconstraints) end

--- This will calculate the length of the bone-chain between the endpoints.
--- If the skeleton have a chain like this (shoulder_l -> upper_arm_l -> lower_arm_l -> hand_l) it will return the length of the upper_arm_l+lower_arm_l
--- ### Example
--- ```lua
--- local length = GetBoneChainLength(animator, "shoulder_l", "hand_l")
--- ```
--- @param handle number -- Animator handle
--- @param begname string -- Name of the start-bone of the chain
--- @param endname string -- Name of the end-bone of the chain
--- @return number length -- Length of the bone chain between "start-bone" and "end-bone"
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoneChainLength)
function GetBoneChainLength(handle, begname, endname) end

--- ### Example
--- ```lua
--- --Search for the first animator in script scope
--- local animator = FindAnimator()
--- --Search for an animator tagged "anim" in script scope
--- local animator = FindAnimator("anim")
--- --Search for an animator tagged "anim2" in entire scene
--- local anim2 = FindAnimator("anim2", true)
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first animator with specified tag or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindAnimator)
function FindAnimator(tag, global) end

--- ### Example
--- ```lua
--- --Search for animators tagged "target" in script scope
--- local targets = FindAnimators("target")
--- for i=1, #targets do
--- 	local target = targets[i]
--- 	...
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all animators with specified tag
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindAnimators)
function FindAnimators(tag, global) end

--- ### Example
--- ```lua
--- local pos = GetAnimatorTransform(animator).pos
--- ```
--- @param handle number -- Animator handle
--- @return TTransform transform -- World space transform of the animator
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimatorTransform)
function GetAnimatorTransform(handle) end

--- When using IK for a character you can use ik-helpers to define where the
--- ### Example
--- ```lua
--- --This will adjust the target transform so that the grip defined by a location node in editor called "ik_hand_l" will reach the target
--- local target = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
--- local adj = GetAnimatorAdjustTransformIK(animator, "ik_hand_l")
--- if adj ~= nil then
--- 	target = TransformToParentTransform(target, adj)
--- end
--- SetAnimatorTransformIK(animator, "shoulder_l", "hand_l", target, 1.0, 0.9)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Name of the location node
--- @return TTransform transform -- World space transform of the animator
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimatorAdjustTransformIK)
function GetAnimatorAdjustTransformIK(handle, name) end

--- ### Example
--- ```lua
--- local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
--- SetAnimatorTransform(animator, t)
--- ```
--- @param handle number -- Animator handle
--- @param transform TTransform -- Desired transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimatorTransform)
function SetAnimatorTransform(handle, transform) end

--- Make all prefab bodies physical and leave control to physics system
--- ### Example
--- ```lua
--- MakeRagdoll(animator)
--- ```
--- @param handle number -- Animator handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#MakeRagdoll)
function MakeRagdoll(handle) end

--- Take control if the prefab bodies and do an optional blend between the current ragdoll state and current animation state
--- ### Example
--- ```lua
--- --Take control of bodies and do a blend during one sec between the animation state and last physics state
--- UnRagdoll(animator, 1.0)
--- ```
--- @param handle number -- Animator handle
--- @param time? number -- Transition time
--- [View Documentation](https://teardowngame.com/experimental/api.html#UnRagdoll)
function UnRagdoll(handle, time) end

--- Single animations, one-shot, will be processed after looping animations.
--- ### Example
--- ```lua
--- --This will play a single animation "Shooting" with a 80% influence but only on the skeleton starting at bone "Spine"
--- PlayAnimation(animator, "Shooting", 0.8, "Spine")
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param filter? string -- Name of the bone and its subtree that will be affected
--- @return number handle -- Handle to the instance that can be used with PlayAnimationInstance, zero if clip reached its end
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayAnimation)
function PlayAnimation(handle, name, weight, filter) end

--- ### Example
--- ```lua
--- --This will play an animation loop "Walking" with a 100% influence on the whole skeleton
--- PlayAnimationLoop(animator, "Walking")
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param filter? string -- Name of the bone and its subtree that will be affected
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayAnimationLoop)
function PlayAnimationLoop(handle, name, weight, filter) end

--- Single animations, one-shot, will be processed after looping animations.
--- ### Example
--- ```lua
--- --This will play a single animation "Shooting" with a 80% influence but only on the skeleton starting at bone "Spine"
--- PlayAnimation(animator, "Shooting", 0.8, "Spine")
--- ```
--- @param handle number -- Animator handle
--- @param instance number -- Instance handle
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param speed? number -- Weight [0,1] of this animation, default is 1.0
--- @return number handle -- Handle to the instance that can be used with PlayAnimationInstance, zero if clip reached its end
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayAnimationInstance)
function PlayAnimationInstance(handle, instance, weight, speed) end

--- This will stop the playing anim-instance
--- ### Example
--- ```lua
--- --This will play an animation "Walking" at a specific time of 1.5s with a 80% influence on the whole skeleton
--- PlayAnimationFrame(animator, "Walking", 1.5, 0.8)
--- ```
--- @param handle number -- Animator handle
--- @param instance number -- Instance handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#StopAnimationInstance)
function StopAnimationInstance(handle, instance) end

--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param time number -- Time in the animation
--- @param weight? number -- Weight [0,1] of this animation, default is 1.0
--- @param filter? string -- Name of the bone and its subtree that will be affected
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayAnimationFrame)
function PlayAnimationFrame(handle, name, time, weight, filter) end

--- You can group looping animations together and use the result of those to blend to target.
--- PlayAnimation will not work here since they are processed last separately from blendgroups.
--- ### Example
--- ```lua
--- --This will blend an entire group with 50% influence
--- BeginAnimationGroup(animator, 0.5)
--- 	PlayAnimationLoop(...)
--- 	PlayAnimationLoop(...)
--- EndAnimationGroup(animator)
--- --You can also create a tree of groups, blending is performed in a depth-first order
--- BeginAnimationGroup(animator, 0.5)
--- 	PlayAnimationLoop(animator, "anim_a", 1.0)
--- 	PlayAnimationLoop(animator, "anim_b", 0.2)
--- 	BeginAnimationGroup(animator, 0.75)
--- 		PlayAnimationLoop(animator, "anim_c", 1.0)
--- 		PlayAnimationLoop(animator, "anim_d", 0.25)
--- 	EndAnimationGroup(animator)
--- EndAnimationGroup(animator)
--- ```
--- @param handle number -- Animator handle
--- @param weight? number -- Weight [0,1] of this group, default is 1.0
--- @param filter? string -- Name of the bone and its subtree that will be affected
--- [View Documentation](https://teardowngame.com/experimental/api.html#BeginAnimationGroup)
function BeginAnimationGroup(handle, weight, filter) end

--- Ends the group created by BeginAnimationGroup
--- ### Example
--- ```lua
--- --First we play a single jump animation affecting the whole skeleton
--- --Then we play an aiming animation on the upper-body, filter="Spine1", keeping the lower-body unaffected
--- --Then we force the single-animations to be processed, this will force the "jump" to be processed.
--- --Then we overwrite just the spine-bone with a mouse controlled rotation("rot")
--- --Result will be a jump animation with the upperbody playing an aiming animation but the pitch of the spine controlled by the mouse("rot")
--- if InputPressed("jump") then
--- 	PlayAnimation(animator, "Jump")
--- end
--- PlayAnimationLoop(animator, "Pistol Idle", aimWeight, "Spine1")
--- PlayAnimationInstances(animator)
--- SetBoneRotation(animator, "Spine1", rot, 1)
--- ```
--- @param handle number -- Animator handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#EndAnimationGroup)
function EndAnimationGroup(handle) end

--- Single animations, one-shot, will be processed after looping animations.
--- By calling PlayAnimationInstances you can force it to be processed earlier and be able to "overwrite" the result of it if you want
--- @param handle number -- Animator handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayAnimationInstances)
function PlayAnimationInstances(handle) end

--- ### Example
--- ```lua
--- local list = GetAnimationClipNames(animator)
--- for i=1, #list do
--- 	local name = list[i]
--- 	..
--- end
--- ```
--- @param handle number -- Animator handle
--- @return table list -- Indexed table with animation names
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimationClipNames)
function GetAnimationClipNames(handle) end

--- ### Example
--- ```lua
--- SetAnimationClipFade(animator, "fire", 0.5, 0.5)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @return number time -- Total duration of the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimationClipDuration)
function GetAnimationClipDuration(handle, name) end

--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param fadein number -- Fadein time of the animation
--- @param fadeout number -- Fadeout time of the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimationClipFade)
function SetAnimationClipFade(handle, name, fadein, fadeout) end

--- ### Example
--- ```lua
--- --This will make the clip run 2x as normal speed
--- SetAnimationClipSpeed(animator, "walking", 2)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param speed number -- Sets the speed factor of the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimationClipSpeed)
function SetAnimationClipSpeed(handle, name, speed) end

--- ### Example
--- ```lua
--- --This will "remove" 1s from the beginning and 2s from the end.
--- TrimAnimationClip(animator, "walking", 1, -2)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param begoffset number -- Time offset from the beginning of the animation
--- @param endoffset? number -- Time offset, positive value means from the beginning and negative value means from the end, zero(default) means at end
--- [View Documentation](https://teardowngame.com/experimental/api.html#TrimAnimationClip)
function TrimAnimationClip(handle, name, begoffset, endoffset) end

--- ### Example
--- ```lua
--- --This will set the current playposition to one second
--- SetAnimationClipLoopPosition(animator, "walking", 1)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @return number time -- Time of the current playposition in the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimationClipLoopPosition)
function GetAnimationClipLoopPosition(handle, name) end

--- @param handle number -- Animator handle
--- @param instance number -- Instance handle
--- @return number time -- Time of the current playposition in the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetAnimationInstancePosition)
function GetAnimationInstancePosition(handle, instance) end

--- @param handle number -- Animator handle
--- @param name string -- Animation name
--- @param time number -- Time in the animation
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetAnimationClipLoopPosition)
function SetAnimationClipLoopPosition(handle, name, time) end

--- ### Example
--- ```lua
--- --This will set the existing rotation by QuatEuler(...)
--- SetBoneRotation(animator, "spine", QuatEuler(0, 180, 0), 1.0)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @param quat TQuat -- Orientation of the bone
--- @param weight? number -- Weight [0,1] default is 1.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBoneRotation)
function SetBoneRotation(handle, name, quat, weight) end

--- ### Example
--- ```lua
--- --This will set the existing local-rotation to point to world space point
--- SetBoneLookAt(animator, "upper_arm_l", Vec(10, 20, 30), 1.0)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @param point table -- World space point as vector
--- @param weight? number -- Weight [0,1] default is 1.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBoneLookAt)
function SetBoneLookAt(handle, name, point, weight) end

--- ### Example
--- ```lua
--- --This will offset the existing rotation by QuatEuler(...)
--- RotateBone(animator, "spine", QuatEuler(0, 5, 0), 1.0)
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @param quat TQuat -- Additive orientation
--- @param weight? number -- Weight [0,1] default is 1.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#RotateBone)
function RotateBone(handle, name, quat, weight) end

--- ### Example
--- ```lua
--- local list = GetBoneNames(animator)
--- for i=1, #list do
--- 	local name = list[i]
--- 	..
--- end
--- ```
--- @param handle number -- Animator handle
--- @return table list -- Indexed table with bone-names
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoneNames)
function GetBoneNames(handle) end

--- ### Example
--- ```lua
--- local body = GetBoneBody(animator, "head")
--- end
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @return number handle -- Handle to the bone's body, or zero if no bone is present.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoneBody)
function GetBoneBody(handle, name) end

--- ### Example
--- ```lua
--- 	local animator = GetPlayerAnimator()
--- 	local bones = GetBoneNames(animator)
--- 	for i=1, #bones do
--- 		local bone = bones[i]
--- 		local t = GetBoneWorldTransform(animator,bone)
--- 		DebugCross(t.pos)
--- 	end
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @return TTransform transform -- World space transform of the bone
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoneWorldTransform)
function GetBoneWorldTransform(handle, name) end

--- ### Example
--- ```lua
--- local lt = getBindPoseTransform(animator, "lefthand")
--- ```
--- @param handle number -- Animator handle
--- @param name string -- Bone name
--- @return TTransform transform -- Local space transform of the bone in bindpose
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoneBindPoseTransform)
function GetBoneBindPoseTransform(handle, name) end

