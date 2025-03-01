Player = Object:extend()
require "collisionBox"


function Player:new(x, y)
	-- Core
	self.location = {}
	self.location.x = x*25 or 0
	self.location.y = y*25 or 0
	
	self.oldLocation = {}
	self.oldLocation.x = self.location.x
	self.oldLocation.y = self.location.y

	--Visuals
	self.image = love.graphics.newImage("assets/numbers/0-9/0.png")
	self.width = 25
	self.height = 25

	-- Game Logistics
	self.value = 0
	self.oldValue = self.value
	self.speed = self.width

	--Collision
	self.collision = CollisionBox(self.location.x, self.location.y, self.width, self.height)
end

function Player:setLocation(x, y)
	self.oldLocation.x = self.location.x
	self.oldLocation.y = self.location.y
	self.location.x = x
	self.location.y = y
	self.collision:setLocation(x, y)
end

-- dir must be either -1 or 1. -1 to go left, 1 to go right
function Player:moveH(dir)
	local locationMod = self.speed*dir
	self:setLocation(self.location.x + locationMod, self.location.y)
end

-- dir must be either -1 or 1. -1 to go up, 1 to go down
function Player:moveV(dir)
	local locationMod = self.speed*dir
	self:setLocation(self.location.x, self.location.y + locationMod)
end

function Player:update()
	local path = ""

	-- Checks for fractions
	if self.value > -1 and self.value < 0 then
		self.value = -1
	end
	if self.value < 1 and self.value > 0 then
		self.value = 1
	end

	-- Checks for out of bounds
	if self.value > 99 then self.value = 99 end
	if self.value < -99 then self.value = -99 end

	-- Update image
	if self.value >= 0 then
		if self.value < 10 then
			path = "assets/numbers/0-9_green/".. self.value..".png"
			self.image = love.graphics.newImage(path)
		else
			local leftNum = math.floor(self.value / 10)
			local rightNum = math.fmod(self.value, 10)
			path = "assets/numbers/0-9_green/"..leftNum..".png"
			self.image = love.graphics.newImage(path)
			path = "assets/numbers/0-9_green/"..rightNum..".png"
			self.image2 = love.graphics.newImage(path)
		end
	else
		if self.value > -10 then
			path = "assets/numbers/0-9_red/"..math.abs(self.value)..".png"
			self.image = love.graphics.newImage(path)
		else
			local leftNum = math.floor(math.abs(self.value)/10)
			local rightNum = math.fmod(math.abs(self.value), 10)
			path = "assets/numbers/0-9_red/"..leftNum..".png"
			self.image = love.graphics.newImage(path)
			path = "assets/numbers/0-9_red/"..rightNum..".png"
			self.iamge2 = love.graphics.newImage(path)
		end
	end
	
end

function Player:draw()
	if (self.value < 10) and (self.value > -10) then 
		-- Single digit case
		love.graphics.draw(self.image, self.location.x, self.location.y, 0, 25/self.image:getWidth(), 25/self.image:getHeight())
	else
		-- Double Digit Case
		love.graphics.draw(self.image, self.location.x, self.location.y, 0, 12.5/self.image:getWidth(), 25/self.image:getHeight())
		love.graphics.draw(self.image2, self.location.x+12.5, self.location.y, 0, 12.5/self.image2:getWidth(), 25/self.image2:getHeight())
	end
end

function Player:changeValue(val)
	self.oldValue = self.value
	self.value = val
end

function Player:undoMove()
	self:setLocation(self.oldLocation.x, self.oldLocation.y)
end