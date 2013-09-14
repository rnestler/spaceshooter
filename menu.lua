
function menuLoad()
	ship = 1
	mainmenu = {
		{
			text="New Game",
			handler = function()
				changeState("game")
			end
		},
		{
			text="Ship",
			handler = function()
				ship = wrap(ship+1,1,2)
			end,
			draw = function(x,y)
				love.graphics.print("Ship: " .. ship, x,y)
			end
		},
		{
			text="Highscore",
			handler = function()
				changeState("highscore")
			end
		},
		{
			text="Quit",
			handler = function()
				love.event.push("quit")
			end
		}
	}
	menu = mainmenu
	menuindex = 1
end

function menuUpdate(dt)
end

function menuDraw()

	for k,v in ipairs(menu) do
		if k==menuindex then
			love.graphics.setColor(0, 0, 255, 255)
		end
		if v.draw then
			v.draw(100, 50+50*k)
		else
			love.graphics.print(v.text, 100, 50+50*k)
		end
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function menuKey(key)
	print("menu key: "..key)
	if key == "escape" then
		print("quit")
		love.event.push("quit")   -- actually causes the app to quit
	elseif key == "up" then
		menuindex = wrap(menuindex-1,1, table.maxn(menu))
	elseif key == "down" then
		menuindex = wrap(menuindex+1,1, table.maxn(menu))
	elseif key == "return" then
		menu[menuindex].handler()
	end
end

