
require("game")
require("menu")
require("highscore")

local state = "menu"

function love.load()
	love.graphics.setMode(800,480)
	background = love.graphics.newImage("data/background.png")

	changeState(state)
end

function changeState(newState)
	if newState == "menu" then
		menuLoad()
	elseif newState == "game" then
		gameLoad()
	elseif newState == "highscore" then
		highscoreLoad()
	end
	state = newState
end

function love.update(dt)
	if state == "menu" then
		menuUpdate(dt)
	elseif state == "game" then
		gameUpdate(dt)
	elseif state == "highscore" then
		highscoreUpdate(dt)
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	if state == "menu" then
		menuDraw()
	elseif state == "game" then
		gameDraw()
	elseif state == "highscore" then
		highscoreDraw()
	end
end

function love.keypressed(key, unicode)
	if state == "menu" then
		menuKey(key)
	elseif state == "game" then
	elseif state == "highscore" then
		highscoreKey(key, unicode)
	end
end

