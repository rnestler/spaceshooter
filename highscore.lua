
function highscoreLoad()
	if highscore == nil then
		highscore = {}
	end
end

function highscoreNew(time)
	if time~=nil and time~=0 then
		table.insert(highscore, {Name="_", Time=time})
	end
end

function highscoreKey(key)
	if key == "return" then
		changeState("menu")
	end
end

function highscoreUpdate()
end

function highscoreDraw()
	love.graphics.print("Name", 100, 100)
	love.graphics.print("Time", 200, 100)
	for k,v in ipairs(highscore) do
		love.graphics.print(v.Name, 100, 100+k*50)
		love.graphics.print("".. v.Time, 200, 100+k*50)
	end
end

