require("util")

function objectNew(world, img)
	obj = {}
	obj.img = love.graphics.newImage(img)
	obj.body = love.physics.newBody(world, 0, 0, "dynamic")
	obj.shape = love.physics.newRectangleShape(0,0, obj.img:getWidth(), obj.img:getHeight())
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setRestitution(0.9) --let it bounce

	obj.acc = 10000

	obj.draw = objectDraw
	obj.rotate = objectRotate
	obj.accelerate = objectAccelerate
	obj.update = objectUpdate
	return obj
end


function objectDraw(this)
	love.graphics.draw(this.img, this.body:getX(), this.body:getY(), this.body:getAngle(), 1, 1, this.img:getWidth()/ 2, this.img:getHeight() / 2)
end

function objectAccelerate(this, dt)
	local angle = this.body:getAngle()
	this.body:applyForce( math.sin(angle)*dt*this.acc, -math.cos(angle)*dt*this.acc)
	--this.speed.x = clamp(this.speed.x + math.sin(this.angle)*dt*this.acc,-100,100)
	--this.speed.y = clamp(this.speed.y - math.cos(this.angle)*dt*this.acc,-100,100)
end

function objectRotate(this, dt)
	this.body:setAngularVelocity(0)
	this.body:setAngle( (this.body:getAngle()-dt*math.pi/2)%(2*math.pi))
end

function objectUpdate(this, dt)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	this.body:setX(this.body:getX()%width)
	this.body:setY(this.body:getY()%height)
end

