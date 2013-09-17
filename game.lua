require("spaceship")
require("asteroid")

function gameLoad()
	particleImage = love.graphics.newImage("data/cloud.png")
	-- no gravity in space
	world = love.physics.newWorld( 0, 0, true ) 

	lost = false
	time = 0
	spawnTime = 0

	objects = {}

	spaceship = spaceshipNew(world, ship);
	table.insert(objects, spaceship)

	explosion = love.graphics.newParticleSystem(particleImage,100)
	explosion:setEmissionRate(100)
	explosion:setSpeed(300,500)
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
	if lost==false and spaceship.health <= 0 then
		spaceship.body:setAwake(false)
		spaceship.body:destroy()
		spaceship.fixture:destroy()
		spaceship.acceleration:setLifetime(0.5)
		spaceship.acceleration:setPosition(spaceship.body:getX(), spaceship.body:getY())
		spaceship.acceleration:setSpread(360)
		spaceship.acceleration:start()
		lost = true
	end
end

function endContact(a,b,c)
end

function gameUpdate(dt)
	world:update(dt)

	for i,obj in pairs(objects) do
		obj:update(dt)
	end
	explosion:update(dt)

	if lost == true then
		if love.keyboard.isDown("return") then
			changeState("highscore")
			highscoreNew(time)
		end
	else
		time = time + dt
		spawnTime = spawnTime + dt
		if spawnTime > 1 then
			spawnTime = 0
			table.insert(objects, asteroidNew(world, time*10))
			for k,v in pairs(objects) do
				v.fixture:setUserData(k)
			end
		end
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
	love.graphics.print("Time: "..time .."s", 200,0)
	for i,obj in pairs(objects) do
		obj:draw()
	end
	love.graphics.draw(explosion,10,10)
end

