function DebugIDs()
	for y=1, WINDOW_HEIGHT do
		for x=1, WINDOW_HEIGHT do
			if elements_on_screen[(y - 1)*WINDOW_WIDTH + x] > 0 then
				love.graphics.setColor(0, 1, 0)
				love.graphics.points(x, y)
			elseif elements_on_screen[(y - 1)*WINDOW_WIDTH + x] < 0 then
				love.graphics.setColor(1, 0, 0)
				love.graphics.points(x, y)
			end
		end
	end
end

function DrawElement(x, y, Element, angle)
	love.graphics.push()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(3)
	love.graphics.translate(x, y)
	love.graphics.rotate(math.rad(angle))

	Element()
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

function Resistor()
	love.graphics.line(-GRID_SIZE, 1.5*GRID_SIZE, GRID_SIZE, 1.5*GRID_SIZE)
	love.graphics.line(-GRID_SIZE, -1.5*GRID_SIZE, GRID_SIZE, -1.5*GRID_SIZE)
	love.graphics.line(-GRID_SIZE, 1.5*GRID_SIZE, -GRID_SIZE, -1.5*GRID_SIZE)
	love.graphics.line(GRID_SIZE, 1.5*GRID_SIZE, GRID_SIZE, -1.5*GRID_SIZE)

	Plug(0, 1.5*GRID_SIZE)
	Plug(0, -1.5*GRID_SIZE)
end

function DrawWire(start_x, start_y, end_x, end_y)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(1)
	love.graphics.line(start_x, start_y, end_x, end_y)
end
