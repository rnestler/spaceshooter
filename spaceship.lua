
require("object")

function spaceshipNew(world, ship)
	ship = ship or 1
	spaceship = objectNew(world, "data/spaceship"..ship..".png")
	spaceship.body:setPosition(100,100)


	local acceleration = love.graphics.newParticleSystem(particleImage,100)
	acceleration:setEmissionRate(100)
	acceleration:setSpeed(300,300)
	acceleration:setGravity(0)
	acceleration:setSizes(1,2)
	acceleration:setColors(255,0,0,128, 255,128,128,0)
	acceleration:setPosition(150,150)
	acceleration:setLifetime(0.1)
	acceleration:setParticleLife(1)
	acceleration:setDirection(0)
	acceleration:setSpread(10/180*3.14)
	acceleration:stop()
	
	spaceship.acceleration = acceleration
	spaceship.health = 5

	spaceship.update = spaceshipUpdate
	spaceship.draw = spaceshipDraw
	spaceship.accelerate = spaceshipAccelerate
	return spaceship
end
		
function spaceshipAccelerate(this, dt)
	if this.health>0 then
		objectAccelerate(this, dt)
		this.acceleration:setPosition(this.body:getX(),this.body:getY())
		this.acceleration:setDirection(this.body:getAngle()+dt/math.abs(dt)*90/180*3.14)
		this.acceleration:start()
	end
end


function spaceshipUpdate(this, dt)
	if this.health>0 then
		objectUpdate(this, dt)
	end
	this.acceleration:update(dt)
end

function spaceshipDraw(this)
	for i=0,this.health-1 do
		love.graphics.draw(this.img, i*24, 0, 0, 24/spaceship.img:getWidth())
	end
	love.graphics.draw(this.acceleration,0,0)
	if this.health>0 then
		love.graphics.print(string.format('Pos: (%i,%i)\nAngle: %1.3f\nSpeed: (%.2f,%.2f)',
		this.body:getX(), this.body:getY(), this.body:getAngle(), this.body:getLinearVelocity() ), 10, 24)
		objectDraw(this)
	end
end

