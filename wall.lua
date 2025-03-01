Wall = Object:extend()
require "collisionBox"

function Wall:new(x, y)
	-- Core
	self.location = {}
	self.location.x = x or 0
	self.location.y = y or 0
	self.image = love.graphics.newImage("assets/coblestone_texture.png")

	-- Collision
	self.collision = CollisionBox(x, y, 25, 25)
end

function Wall:draw()
	love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/self.image:getWidth(), 25/self.image:getHeight())
end