
function highscoreLoad()
	textblinktime = 0
	textblink = false
	if highscore == nil then
		highscore = {}
		if love.filesystem.isFile( "highscore.csv" ) then
			file = love.filesystem.newFile("highscore.csv")
			file:open("r")
			data = file:read()
			for k, v in string.gmatch(data, "([%g ]+),([%w%.]+)") do
				print(k,v)
				table.insert(highscore, {Name=k, Time=tonumber(v)})
			end
			file:close()
		else
			love.filesystem.write( "highscore.csv", "")
		end
	end
end

function highscoreSave()
	if highscore == nil then
		return
	end
	file = love.filesystem.newFile("highscore.csv")
	file:open("w")
	for k,v in ipairs(highscore) do
		file:write(v.Name .. ",".. v.Time .. "\n")
	end
end

function highscoreNew(time)
	if time~=nil and time~=0 then
		for k,v in ipairs(highscore) do
			if time > v.Time then
				pos = k
				table.insert(highscore, k, {Name="", Time=time})
				return
			end
		end
		pos = 1
		table.insert(highscore, {Name="", Time=time})
		print("New Highscore: "..pos.." "..time)
	end
end

function highscoreKey(key, unicode)
	if pos then
		if key == "return" then
			pos = nil
		elseif key == "backspace" then
			highscore[pos].Name = string.sub(highscore[pos].Name, 1,-2)
		else
			if unicode > 31 and unicode < 127 then
				highscore[pos].Name = highscore[pos].Name .. string.char(unicode)
			end
		end
	else
		if key == "return" then
			changeState("menu")
		end
	end
end

function highscoreUpdate(dt)
	textblinktime = textblinktime + dt
	if pos then
		if textblinktime >= 1.0 then
			textblinktime = 0
			textblink = false
		elseif textblinktime >= 0.5 then
			textblink = true
		end
	end
end

function highscoreDraw()
	love.graphics.print("Name", 100, 100)
	love.graphics.print("Time", 200, 100)
	for k,v in ipairs(highscore) do
		local name = v.Name
		if pos==k and textblink then
			name = name.."_"
		end
		love.graphics.print(name, 100, 100+k*50)
		love.graphics.print("".. v.Time, 200, 100+k*50)
	end
end

