SpecialTile = Object:extend()
require "collisionBox"

function SpecialTile:new(Type, value, x, y)
	-- Core
	self.location = {}
	self.location.x = x or 0
	self.location.y = y or 0
	self.Type = Type
	self.value = value or 1

	-- Figure out what image should be on this tile
	local path = ""
	if self.Type == "Plus" then
		path = "assets/numbers/Plus/+"..self.value..".png"
	elseif self.Type == "Minus" then
		path = "assets/numbers/Minus/-"..self.value..".png"
	elseif self.Type == "Division" then
		path = "assets/numbers/Division/"..self.value..".png"
	elseif self.Type == "Times" then
		path = "assets/numbers/Times/"..self.value..".png"
	end
	self.image = love.graphics.newImage(path)

	-- Collision
	self.collision = CollisionBox(self.location.x, self.location.y, 25, 25)

	--Gameplay Logic
	self.ready = true
end

function SpecialTile:draw()
	-- Draw the tile at 192x192 scale
	love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/224, 25/224)
end