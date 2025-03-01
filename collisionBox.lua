CollisionBox = Object:extend()

function CollisionBox:new(x, y, w, h)
	-- Setup
	self.w = w
	self.h = h
	self:setLocation(x, y)
end

function CollisionBox:setLocation(x, y)
	self.x1 = x
	self.y1 = y
	self.x2 = x + self.w
	self.y2 = y + self.h
end


-- Returns true if this box is overlapping otherBox
function CollisionBox:isOverlapping(otherBox)
	-- Horizontal, then vertical collision check
	if ((self.x1 < otherBox.x1) and (self.x2 > otherBox.x1)) or ((self.x1 < otherBox.x2) and (self.x2 > otherBox.x2)) or ((self.x1 >= otherBox.x1) and (self.x2 <= otherBox.x2)) then
		if ((self.y1 < otherBox.y1) and (self.y2 > otherBox.y1)) or ((self.y1 < otherBox.y2) and (self.y2 > otherBox.y2)) or ((self.y1 >= otherBox.y1) and (self.y2 <= otherBox.y2)) then
			return true
		end
	end

	return false
end