
require("game")
require("menu")

function love.load()
	love.graphics.setMode(800,480)
	background = love.graphics.newImage("data/background.png")

	state = "menu"
	menuLoad()
end

function changeState(newState)
	if newState == "menu" then
		menuLoad()
	elseif newState == "game" then
		gameLoad()
	end
	state = newState
end

function love.update(dt)
	if state == "menu" then
		menuUpdate(dt)
	elseif state == "game" then
		gameUpdate(dt)
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	if state == "menu" then
		menuDraw()
	elseif state == "game" then
		gameDraw()
	end
end

function love.keypressed(key)
	if state == "menu" then
		menuKey(key)
	elseif state == "game" then
	end
end

