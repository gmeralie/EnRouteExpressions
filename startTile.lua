StartTile = Object:extend()

function StartTile:new(x, y)
	self.location = {}
	self.location.x = x
	self.location.y = y
	self.image = love.graphics.newImage("assets/GridTiles/Grids_start.png")
end

function StartTile:draw()
	love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/self.image:getWidth(), 25/self.image:getHeight())
end