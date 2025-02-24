elements_on_screen = {}

function InTable(arr, v)
	for _, i in ipairs(arr) do
		if i == v then
			return true
		end
	end
	return false
end

function AddSprite(pos_x, pos_y, draw_func, angle)
	table.insert(sprites, { x = pos_x, y = pos_y, draw = draw_func, angle = angle })
end

function FillSpriteID(x, y, id)
	x = x - 1.5*GRID_SIZE
	y = y - 1.5*GRID_SIZE
	for i=y, y + 3*GRID_SIZE do
		for j=x, x + 3*GRID_SIZE do
			elements_on_screen[(i - 1)*WINDOW_WIDTH + j] = id
		end
	end
end

function InSprite(x, y)
	return elements_on_screen[(y - 1)*WINDOW_WIDTH + x]
end
