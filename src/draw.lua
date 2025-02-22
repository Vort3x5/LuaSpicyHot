function DrawElement(x, y, Element)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(3)

	Element(x, y)
end

function Cursor(x, y)
	love.graphics.setColor(0, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.line(x, y, x + GRID_SIZE, y)
	love.graphics.line(x - GRID_SIZE, y, x, y)
	love.graphics.line(x, y, x, y + GRID_SIZE)
	love.graphics.line(x, y, x, y - GRID_SIZE)
end

function Plug(x, y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("fill", x, y, GRID_SIZE / 5)
end

function Resistor(x, y)
	love.graphics.line(x - GRID_SIZE, y, x + GRID_SIZE, y)
	love.graphics.line(x - GRID_SIZE, y, x - GRID_SIZE, y - 3*GRID_SIZE)
	love.graphics.line(x + GRID_SIZE, y, x + GRID_SIZE, y - 3*GRID_SIZE)
	love.graphics.line(x - GRID_SIZE, y - 3*GRID_SIZE, x + GRID_SIZE, y - 3*GRID_SIZE)

	Plug(x, y)
	Plug(x, y - 3*GRID_SIZE)
end
