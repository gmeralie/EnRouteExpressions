Level1 = Object:extend()

function Level1:new() end

function Level1:loadLevel()
	obstacles = {}
	exits = {}
	operators = {}
	tiles = {}
	wallArea(5, 5, 19, 5)
	addTile("wall", 5, 6)
	addTile("wall", 19, 6)
	wallArea(5, 7, 19, 7)
	addTileArea(7, 6, 17, 6, "d")
	addTile("start", 6, 6)
	local action = {}
	action.value = 0
	addTile("exit", 18, 6, action)
	player = Player(6, 6)
end