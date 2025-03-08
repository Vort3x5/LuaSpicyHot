function ExitMod()
	element = 0
	modifying = false
	ResetWiring()
end

function Rotate()
	element.angle = (element.angle + 90) % 360
end

function SetModElement()
	element = sprites[id]
	from_wire.state = false
end

function SetModWire()
	element = wires[-id]
	from_wire = {
		state = true,
		x = cursor.x,
		y = cursor.y,
	}
end

function WireFromElement(key)
	local start_x, start_y, dir = cursor.x, cursor.y, 0
	if InTable(FLAT_DEGREES, element.angle) then
		if InTable(LEFT_KEYS, key) then
			cursor.x, cursor.y = element.x - 1.5*GRID_SIZE, element.y
			dir = L
		elseif InTable(RIGHT_KEYS, key) then
			cursor.x, cursor.y = element.x + 1.5*GRID_SIZE, element.y
			dir = R
		end
	else
		if InTable(DOWN_KEYS, key) then
			cursor.x, cursor.y = element.x, element.y + 1.5*GRID_SIZE
			dir = D
		elseif InTable(UP_KEYS, key) then
			cursor.x, cursor.y = element.x, element.y - 1.5*GRID_SIZE
			dir = U
		end
	end
	if start_x ~= cursor.x or start_y ~= cursor.y then
		drawing_wire = {
			state = true,
			start_x = cursor.x,
			start_y = cursor.y,
			dir = dir
		}
	end
end

function WireFromWire(key)
	if InTable(LEFT_KEYS, key) then
		cursor.x, cursor.y = from_wire.x, from_wire.y
		dir = L
	elseif InTable(DOWN_KEYS, key) then
		cursor.x, cursor.y = from_wire.x, from_wire.y
		dir = D
	elseif InTable(UP_KEYS, key) then
		cursor.x, cursor.y = from_wire.x, from_wire.y
		dir = U
	elseif InTable(RIGHT_KEYS, key) then
		cursor.x, cursor.y = from_wire.x, from_wire.y
		dir = R
	end
	drawing_wire = {
		state = true,
		start_x = from_wire.x,
		start_y = from_wire.y,
		dir = dir,
		id = element.id
	}
end
