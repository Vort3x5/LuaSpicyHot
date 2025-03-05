function Abort(err)
	local red = "\27[31m"
	local reset = "\27[0m"
	io.write(red .. err .. reset .. "\n")
	love.event.quit()
end

function ResetWiring()
	drawing_wire = {
		state = false,
		start_x = 0,
		start_y = 0,
		dir = 0
	}
end

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

function AddEdge(start_x, start_y, end_x, end_y, direction)
	table.insert(wires, {
		start_x = start_x, 
		start_y = start_y, 
		end_x = end_x,
		end_y = end_y,
		direction = direction,
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

function FillEdgeID(start_x, start_y, end_x, end_y, direction, id)
	local L, D, U, R = 1, 2, 3, 4
	if direction == L or direction == R then
		i_start = start_y - GRID_SIZE 
		i_end = end_y + GRID_SIZE
		j_start = start_x
		j_end = end_x
	elseif direction == D or direction == U then
		i_start = start_y
		i_end = end_y
		j_start = start_x - GRID_SIZE
		j_end = end_x + GRID_SIZE
	else
		Abort("ERROR: No direction given")
	end
	for i=i_start, i_end do
		for j=j_start, j_end do
			elements_on_screen[(i - 1)*WINDOW_WIDTH + j] = id
		end
	end
end

function InSprite(x, y)
	return elements_on_screen[(y - 1)*WINDOW_WIDTH + x]
end
