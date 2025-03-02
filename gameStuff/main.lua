Object = require "libraries/classic"
require "player"
require "wall"
require "specialTile"
require "winTile"
require "normalTile"
require "levels"
require "startTile"

function love.load()
	love.window.setTitle("EnRouteExpressions")
	love.window.setMode(800, 600, {resizable=true, minwidth=400, minheight=300})
	background = love.graphics.newImage("assets/patterned.png")
	maxLevels = 9
	levels = {}
	table.insert(levels, 0, StartScreen())
	table.insert(levels, 1, Level1())
	table.insert(levels, 2, Level2())
	table.insert(levels, 3, Level3())
	table.insert(levels, 4, Level4())
	table.insert(levels, 5, Level5())
	table.insert(levels, 6, Level6())
	table.insert(levels, 7, Level7())
	table.insert(levels, 8, Level8())
	table.insert(levels, 9, Level9())
	levels.gameOver = YouWin()
	currLevelIndex = 0
	currLevel = levels[0]
	obstacles = {}
	operators = {}
	tiles = {}
	exits = {}
	player = Player(0, 0)
	currLevel.loadLevel()
	prevPlayerValue = 0
end

function love.update()
	-- Wall Collision Checks
	for i, v in ipairs(obstacles) do
		if v.collision:isOverlapping(player.collision) then
			player:undoMove()
		end
	end

	-- Operator Collision Checks
	for i, v in ipairs(operators) do
		if v.collision:isOverlapping(player.collision) then
			if v.ready then
				v.ready = false
				doOperation(v)
			end
		else
			v.ready = true
		end
	end

	-- Exit Collision Checks
	for i, v in ipairs(exits) do
		if v.collision:isOverlapping(player.collision)then
			-- If the player's current value = the exit's value, go to the next level. 
			if v.value == player.value then
				print("You Win!")
				currLevelIndex = currLevelIndex+1
				if currLevelIndex > maxLevels then
					currLevel = levels.gameOver
					currLevelIndex = 1000
				else
					currLevel = levels[currLevelIndex]
				end
				currLevel.loadLevel()
			end
		end
	end

	player:update()
end

function love.draw()
	-- Draws the image all over the background to fill the window. 
	love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth()/background:getWidth(), love.graphics.getHeight()/background:getHeight())

    for i, v in ipairs(tiles) do
    	v:draw()
    end

    for i, v in ipairs(obstacles) do
    	v:draw()
    end

    for i, v in ipairs(operators) do 
    	v:draw()
    end

    for i, v in ipairs(exits) do
    	v:draw()
    end

    if not (currLevel == levels.gameOver) and not (currLevel == levels[0]) then
	    player:draw()
	end
end

function love.keypressed(key, scancode, isrepeat)
	-- GameOver Restart
	if currLevel == levels.gameOver then
		currLevelIndex = 0
		currLevel = levels[currLevelIndex]
		currLevel.loadLevel()
	elseif currLevel == levels[0] then
		currLevelIndex = currLevelIndex+1
		currLevel = levels[currLevelIndex]
		currLevel.loadLevel()
	else
		-- Movement input handling
		if key == "right" then
			player:moveH(1)
		elseif key == "left" then
			player:moveH(-1)
		elseif key == "up" then
			player:moveV(-1)
		elseif key == "down" then
			player:moveV(1)
		end

		-- Fullscreen toggle
		if key == "f" then
			if not love.window.isMaximized() then
				love.window.maximize()
			else love.window.restore() end
		end

		-- Close game
		if key == "escape" then
			love.event.quit()
		end

		-- Restart level
		if key == "r" then
			currLevel.loadLevel()
		end
	end
end

function doOperation(v)
	if v.Type == "Plus" then
		player.value = player.value + v.value
	elseif v.Type == "Minus" then
		player.value = player.value - v.value
	elseif v.Type == "Division" then
		player.value = player.value / v.value
	elseif v.Type == "Times" then
		player.value = player.value * v.value
	end
	print(player.value)
end

function addTile(class, tileX, tileY, action)
	local x = tileX*25
	local y = tileY*25
	-- Walls
	if class == "wall" then
		table.insert(obstacles, Wall(x, y))
	end

	-- Operators
	if class == "plus" then
		table.insert(operators, SpecialTile("Plus", action, x, y))
	elseif class == "minus" then
		table.insert(operators, SpecialTile("Minus", action, x, y))
	elseif class == "times" then
		table.insert(operators, SpecialTile("Times", action, x, y))
	elseif class == "division" then
		table.insert(operators, SpecialTile("Division", action, x, y))
	end

	-- Win Tile
	if class == "exit" then
		table.insert(exits, WinTile(x, y, action))
	end

	-- Regular Tile
	if class == "normal" then
		table.insert(tiles, NormalTile(x, y, action))
	end

	-- start tile
	if class == "start" then
		table.insert(tiles, StartTile(x, y))
	end
end

function wallArea(x1, y1, x2, y2)
	local currx = x1
	while currx <= x2 do 
		local curry = y1
		while curry <= y2 do 
			addTile("wall", currx, curry)
			curry = curry + 1
		end
		currx = currx + 1
	end
end

function addTileArea(x1, y1, x2, y2, startingColor)
	local currx = x1
	local colorc = startingColor
	while currx <= x2 do 
		local curry = y1
		local colorr = colorc
		while curry <= y2 do 
			addTile("normal", currx, curry, colorr)
			curry = curry + 1
			if colorr == "d" then
				colorr = "l"
			elseif colorr == "l" then
				colorr = "d"
			end
		end
		currx = currx + 1
		if colorc == "d" then
			colorc = "l"
		elseif colorc == "l" then
			colorc = "d"
		end
	end
end

