elements_on_screen = {}

function InTable(arr, v)
	for _, i in ipairs(arr) do
		if i == v then
			return true
		end
	end
	return false
end

function AddNode(pos_x, pos_y, draw_func, angle)
	table.insert(sprites, { 
		x = pos_x, 
		y = pos_y, 
		draw = draw_func, 
		angle = angle 
	})
end

function AddEdge(start_x, start_y, curr_x, curr_y, direction, id)
	table.insert(wires, {
		start_x = start_x, 
		start_y = start_y, 
		end_x = curr_x,
		end_y = curr_y,
		direction = direction,
		id = id
	})
end

function FillNodeID(x, y, id)
	x = x - 1.5*GRID_SIZE
	y = y - 1.5*GRID_SIZE
	for i=y, y + 3*GRID_SIZE do
		for j=x, x + 3*GRID_SIZE do
			elements_on_screen[(i - 1)*WINDOW_WIDTH + j] = id
		end
	end
end

function FillEdgeID(start_x, start_y, curr_x, curr_y, direction)
	local L, D, U, R = 1, 2, 3, 4
	if direction == L or direction == R then
	else
	end
end

function InSprite(x, y)
	return elements_on_screen[(y - 1)*WINDOW_WIDTH + x]
end
