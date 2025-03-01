Level2 = Object:extend()
function Level2.loadLevel()
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
	action.value = 1
	addTile("exit", 18, 6, action)
	player = Player(6, 6)
	addTile("plus", 13, 6, 1)
end