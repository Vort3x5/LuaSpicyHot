function DrawElement(x, y, Element, angle)
	love.graphics.push()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(3)
	love.graphics.translate(x, y)
	love.graphics.rotate(math.rad(angle) or 0)

	Element(x, y)
	love.graphics.pop()
end

function Cursor(x, y)
	love.graphics.setColor(0, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.line(0, 0, GRID_SIZE, 0)
	love.graphics.line(-GRID_SIZE, 0, 0, 0)
	love.graphics.line(0, 0, 0, GRID_SIZE)
	love.graphics.line(0, 0, 0, -GRID_SIZE)
end

function Plug(x, y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("fill", x, y, GRID_SIZE / 5)
end

function Resistor(x, y)
	love.graphics.line(-GRID_SIZE, 0, GRID_SIZE, 0)
	love.graphics.line(-GRID_SIZE, 0, -GRID_SIZE, -3*GRID_SIZE)
	love.graphics.line(GRID_SIZE, 0, GRID_SIZE, -3*GRID_SIZE)
	love.graphics.line(-GRID_SIZE, -3*GRID_SIZE, GRID_SIZE, -3*GRID_SIZE)

	Plug(0, 0)
	Plug(0, -3*GRID_SIZE)
end
