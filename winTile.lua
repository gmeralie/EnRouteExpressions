WinTile = Object:extend()
require "collisionBox"

function WinTile:new(x, y, value)
	-- Core
	self.location = {}
	self.location.x = x or 0
	self.location.y = y or 0
	self.value = value or 1

	-- Visual
	self.image = love.graphics.newImage("assets/GridTiles/Grids_darkFinish.png")
	local path = "assets/numbers/0-9/"..self.value..".png"
	self.number = love.graphics.newImage(path)

	-- Collision
	self.collision = CollisionBox(self.location.x, self.location.y, 25, 25)
end

function WinTile:draw()
	love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/self.image:getWidth(), 25/self.image:getHeight())
	love.graphics.draw(self.number, self.location.x, self.location.y, 0, 25/self.number:getWidth(), 25/self.number:getHeight())
end



