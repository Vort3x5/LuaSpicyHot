function ClearIDs()
	for y=1, WINDOW_HEIGHT do
		for x=1, WINDOW_HEIGHT do
			elements_on_screen[(y - 1)*WINDOW_WIDTH + x] = 0
		end
	end
end

function Abort(err)
	local red = "\27[31m"
	local reset = "\27[0m"
	io.write(red .. err .. reset .. "\n")
	love.event.quit()
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
	node_count = node_count + 1
	table.insert(sprites, { 
		x = pos_x, 
		y = pos_y, 
		draw = draw_func, 
		angle = angle 
	})
end

function AddEdge(start_x, start_y, end_x, end_y, direction, id)
	table.insert(wires, {
		start_x = start_x, 
		start_y = start_y, 
		end_x = end_x,
		end_y = end_y,
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

function FillEdgeID(start_x, start_y, end_x, end_y, direction, id)
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
	if i_start > i_end then
		i_start, i_end = i_end, i_start
	end
	if j_start > j_end then
		j_start, j_end = j_end, j_start
	end
	for i=i_start, i_end do
		for j=j_start, j_end do
			elements_on_screen[(i - 1)*WINDOW_WIDTH + j] = -id
		end
	end
end

function InSprite(x, y)
	return elements_on_screen[(y - 1)*WINDOW_WIDTH + x]
end

function Max(a, b)
	if a > b then
		return a
	else
		return b
	end
end

function Sort(arr)
    local mx_value = arr.mx
    arr.mx = nil
    local sorter = {}
    for i = 1, mx_value do
        sorter[i] = 0
    end
    for _, v in ipairs(arr) do
        sorter[v] = sorter[v] + 1
    end
    for i = #arr, 1, -1 do
        arr[i] = nil
    end

    for i = 1, mx_value do
        for j = 1, sorter[i] do
            table.insert(arr, i)
        end
    end
    arr.mx = mx_value
end
