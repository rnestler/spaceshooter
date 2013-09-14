require("object")

function asteroidNew(world)
	asteroid = objectNew(world, "data/asteroid.png")
	asteroid.body:setLinearVelocity(math.random(50), math.random(50))
	asteroid.body:setX(math.random(800))
	asteroid.body:setY(math.random(480))
	asteroid.body:setAngularVelocity(math.random())
	asteroid.rotSpeed = math.random()

	asteroid.update = asteroidUpdate

	return asteroid
end

function asteroidUpdate(this, dt)
	objectUpdate(this, dt)
end


