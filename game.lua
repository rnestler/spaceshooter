require("spaceship")
require("asteroid")

function gameLoad()
	particleImage = love.graphics.newImage("data/cloud.png")
	-- no gravity in space
	world = love.physics.newWorld( 0, 0, true ) 

	time = 0

	objects = {}

	spaceship = spaceshipNew(world);
	table.insert(objects, spaceship)

	explosion = love.graphics.newParticleSystem(particleImage,100)
	explosion:setEmissionRate(100)
	explosion:setSpeed(300,300)
	explosion:setGravity(0)
	explosion:setSizes(1,2)
	explosion:setColors(255,255,255,128, 255,255,255,0)
	explosion:setPosition(150,150)
	explosion:setLifetime(0.1)
	explosion:setParticleLife(1)
	explosion:setDirection(0)
	explosion:setSpread(360)
	explosion:stop()

	world:setCallbacks(beginContact, endContact)

	for i=1,10 do
		table.insert(objects, asteroidNew(world))
	end
	print(spaceship.body:getLinearDamping())

	for k,v in ipairs(objects) do
		v.fixture:setUserData(k)
	end
	for k,v in pairs(spaceship) do
		print(k,v)
	end
end

function beginContact(a,b,c)
	local aa = a:getUserData()
	local bb = b:getUserData()
	local oa = objects[aa]
	local ob = objects[bb]

	local px,py = c:getPositions()

	print("Collided: " .. aa .. " and " .. bb, "Friction: " .. c:getFriction())
	explosion:setPosition(px, py)
	explosion:start()

	if aa == 1 then
		oa.health = oa.health-1
		ob.body:setAwake(false)
		ob.body:destroy()
		ob.fixture:destroy()
		objects[bb] = nil;
	end

	if bb == 1 then
		ob.health = ob.health-1
		oa.body:setAwake(false)
		oa.body:destroy()
		oa.fixture:destroy()
		objects[aa] = nil;
	end
end

function endContact(a,b,c)
end

function gameUpdate(dt)
	time = time + dt
	world:update(dt)

	for i,obj in pairs(objects) do
		obj:update(dt)
	end
	explosion:update(dt)

	if spaceship.health <= 0 then
		changeState("menu")
	elseif spaceship.body then
		if love.keyboard.isDown("left") then
			spaceship:rotate(dt);
		end
		if love.keyboard.isDown("right") then
			spaceship:rotate(-dt);
		end
		if love.keyboard.isDown("up") then
			spaceship:accelerate(dt)
		end
		if love.keyboard.isDown("down") then
			spaceship:accelerate(-dt)
		end
	end
end

function gameDraw()
	for i,obj in pairs(objects) do
		obj:draw()
	end
	love.graphics.draw(explosion,10,10)
end

