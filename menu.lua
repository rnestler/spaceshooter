
function menuLoad()
	active = 1
end

function menuUpdate(dt)
end

function menuDraw()

	if active == 1 then
		love.graphics.setColor(0, 0, 255, 255)
	end
	love.graphics.print("New Game", 100,100)
	love.graphics.setColor(255, 255, 255, 255)

	if active == 2 then
		love.graphics.setColor(0, 0, 255, 255)
	end
	love.graphics.print("Quit", 100,150)
	love.graphics.setColor(255, 255, 255, 255)
end

function menuKey(key)
	print("menu key: "..key)
	if key == "escape" then
		print("quit")
		love.event.push("quit")   -- actually causes the app to quit
	elseif key == "up" then
		active = clamp(active-1,1,2)
	elseif key == "down" then
		active = clamp(active+1,1,2)
	elseif key == "return" then
		print("return")
		if active == 1 then
			changeState("game")
		elseif active == 2 then
			love.event.push("quit")   -- actually causes the app to quit
		end
	end
end
