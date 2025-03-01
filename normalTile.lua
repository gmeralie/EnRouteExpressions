NormalTile = Object:extend()

function NormalTile:new(x, y, dl)
	-- Core
	self.location = {}
	self.location.x = x or 0
	self.location.y = y or 0

	-- Visual
	dl = dl or "d"
	local path = ""
	if dl == "d" then
		path = "assets/GridTiles/Grids_dark.png"
	elseif dl == "l" then
		path = "assets/GridTiles/Grids_light.png"
	end
	self.image = love.graphics.newImage(path)
end

function NormalTile:draw()
	love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/self.image:getWidth(), 25/self.image:getHeight())
end


