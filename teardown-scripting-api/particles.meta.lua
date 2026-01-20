--- @meta

--- Reset to default particle state, which is a plain, white particle of radius 0.5.
--- Collision is enabled and it alpha animates from 1 to 0.
--- ### Example
--- ```lua
--- function client.init()
--- 	ParticleReset()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleReset)
function ParticleReset() end

--- Set type of particle
--- @param type string -- Type of particle. Can be "smoke" or "plain".
--- ### Example
--- ```lua
--- function client.init()
--- 	ParticleType("smoke")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleType)
function ParticleType(type) end

--- @param type number -- Tile in the particle texture atlas (0-15)
--- ### Example
--- ```lua
--- function client.init()
--- 	--Smoke particle
--- 	ParticleTile(0)
--- 	--Fire particle
--- 	ParticleTile(5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleTile)
function ParticleTile(type) end

--- Set particle color to either constant (three arguments) or linear interpolation (six arguments)
--- @param r0 number -- Red value
--- @param g0 number -- Green value
--- @param b0 number -- Blue value
--- @param r1? number -- Red value at end
--- @param g1? number -- Green value at end
--- @param b1? number -- Blue value at end
--- ### Example
--- ```lua
--- function client.init()
--- 	--Constant red
--- 	ParticleColor(1,0,0)
--- 	--Animating from yellow to red
--- 	ParticleColor(1,1,0, 1,0,0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleColor)
function ParticleColor(r0, g0, b0, r1, g1, b1) end

--- Set the particle radius. Max radius for smoke particles is 1.0.
--- @param r0 number -- Radius
--- @param r1? number -- End radius
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Constant radius 0.4 meters
--- 	ParticleRadius(0.4)
--- 	--Interpolate from small to large
--- 	ParticleRadius(0.1, 0.7)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleRadius)
function ParticleRadius(r0, r1, interpolation, fadein, fadeout) end

--- Set the particle alpha (opacity).
--- @param a0 number -- Alpha (0.0 - 1.0)
--- @param a1? number -- End alpha (0.0 - 1.0)
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Interpolate from opaque to transparent
--- 	ParticleAlpha(1.0, 0.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleAlpha)
function ParticleAlpha(a0, a1, interpolation, fadein, fadeout) end

--- Set particle gravity. It will be applied along the world Y axis. A negative value will move the particle downwards.
--- @param g0 number -- Gravity
--- @param g1? number -- End gravity
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Move particles slowly upwards
--- 	ParticleGravity(2)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleGravity)
function ParticleGravity(g0, g1, interpolation, fadein, fadeout) end

--- Particle drag will slow down fast moving particles. It's implemented slightly different for
--- smoke and plain particles. Drag must be positive, and usually look good between zero and one.
--- @param d0 number -- Drag
--- @param d1? number -- End drag
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Slow down fast moving particles
--- 	ParticleDrag(0.5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleDrag)
function ParticleDrag(d0, d1, interpolation, fadein, fadeout) end

--- Draw particle as emissive (glow in the dark). This is useful for fire and embers.
--- @param d0 number -- Emissive
--- @param d1? number -- End emissive
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Highly emissive at start, not emissive at end
--- 	ParticleEmissive(5, 0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleEmissive)
function ParticleEmissive(d0, d1, interpolation, fadein, fadeout) end

--- Makes the particle rotate. Positive values is counter-clockwise rotation.
--- @param r0 number -- Rotation speed in radians per second.
--- @param r1? number -- End rotation speed in radians per second.
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Rotate fast at start and slow at end
--- 	ParticleRotation(10, 1)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleRotation)
function ParticleRotation(r0, r1, interpolation, fadein, fadeout) end

--- Stretch particle along with velocity. 0.0 means no stretching. 1.0 stretches with the particle motion over
--- one frame. Larger values stretches the particle even more.
--- @param s0 number -- Stretch
--- @param s1? number -- End stretch
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Stretch particle along direction of motion
--- 	ParticleStretch(1.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleStretch)
function ParticleStretch(s0, s1, interpolation, fadein, fadeout) end

--- Make particle stick when in contact with objects. This can be used for friction.
--- @param s0 number -- Sticky (0.0 - 1.0)
--- @param s1? number -- End sticky (0.0 - 1.0)
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Make particles stick to objects
--- 	ParticleSticky(0.5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleSticky)
function ParticleSticky(s0, s1, interpolation, fadein, fadeout) end

--- Control particle collisions. A value of zero means that collisions are ignored. One means full collision.
--- It is sometimes useful to animate this value from zero to one in order to not collide with objects around
--- the emitter.
--- @param c0 number -- Collide (0.0 - 1.0)
--- @param c1? number -- End collide (0.0 - 1.0)
--- @param interpolation? string -- Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
--- @param fadein? number -- Fade in between t=0 and t=fadein. Default is zero.
--- @param fadeout? number -- Fade out between t=fadeout and t=1. Default is one.
--- ### Example
--- ```lua
--- function client.init()
--- 	--Disable collisions
--- 	ParticleCollide(0)
--- 	--Enable collisions over time
--- 	ParticleCollide(0, 1)
--- 	--Ramp up collisions very quickly, only skipping the first 5% of lifetime
--- 	ParticleCollide(1, 1, "constant", 0.05)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleCollide)
function ParticleCollide(c0, c1, interpolation, fadein, fadeout) end

--- Set particle bitmask. The value 256 means fire extinguishing particles and is currently the only
--- flag in use. There might be support for custom flags and queries in the future.
--- @param bitmask number -- Particle flags (bitmask 0-65535)
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Fire extinguishing particle
--- 	ParticleFlags(256)
--- 	SpawnParticle(Vec(0, 10, 0), -0.1, math.random() + 1)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ParticleFlags)
function ParticleFlags(bitmask) end

--- Spawn particle using the previously set up particle state. You can call this multiple times
--- using the same particle state, but with different position, velocity and lifetime. You can
--- also modify individual properties in the particle state in between calls to to this function.
--- @param pos TVec -- World space point as vector
--- @param velocity TVec -- World space velocity as vector
--- @param lifetime number -- Particle lifetime in seconds
--- ### Example
--- ```lua
--- function client.tick()
--- 	ParticleReset()
--- 	ParticleType("smoke")
--- 	ParticleColor(0.7, 0.6, 0.5)
--- 	--Spawn particle at world origo with upwards velocity and a lifetime of ten seconds
--- 	SpawnParticle(Vec(0, 5, 0), Vec(0, 1, 0), 10.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SpawnParticle)
function SpawnParticle(pos, velocity, lifetime) end

