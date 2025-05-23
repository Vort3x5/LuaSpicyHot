function ResetWiring()
	drawing_wire.state = false
	from_wire.state = false
	from_wire.x = 0
	from_wire.y = 0
end

function ExitMod()
	element = 0
	modifying = false
	ResetWiring()
end

function Rotate()
	element.angle = (element.angle + 90) % 360
end

function CursorMovement()
	if love.keyboard.isDown(LEFT_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == L) then
		cursor.x = cursor.x - GRID_SIZE / 5
	elseif love.keyboard.isDown(DOWN_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == D) then
		cursor.y = cursor.y + GRID_SIZE / 5
	elseif love.keyboard.isDown(UP_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == U) then
		cursor.y = cursor.y - GRID_SIZE / 5
	elseif love.keyboard.isDown(RIGHT_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == R) then
		cursor.x = cursor.x + GRID_SIZE / 5
	end
end

function SetModElement(id)
	element = sprites[id]
	element.id = id
	from_wire.state = false
	from_wire.src = id
end

function SetModWire(id)
	element = wires[-id]
	from_wire.state = true
	from_wire.x = cursor.x
	from_wire.y = cursor.y
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
		curr_wire = curr_wire + 1
		drawing_wire.state = true
		drawing_wire.start_x = cursor.x
		drawing_wire.start_y = cursor.y
		drawing_wire.dir = dir
		drawing_wire.id = curr_wire
		WireAddNode(drawing_wire.id, element.id)
	end
end

function WireFromWire(key)
	local start_x, start_y, dir = cursor.x, cursor.y, 0
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
	drawing_wire.state = true
	drawing_wire.start_x = from_wire.x
	drawing_wire.start_y = from_wire.y
	drawing_wire.dir = dir
	if start_x ~= cursor.x or start_y ~= cursor.y then
		curr_wire = curr_wire + 1
	end
end

function HandleSettingResistance(key)
	if setting_resistance then
		if key == "return" then
			local value = tonumber(resistance_input)
			if value then
				resistors[selected_resistor] = value
			end
			setting_resistance = false
			resistance_input = ""
		elseif key == "backspace" then
			resistance_input = resistance_input:sub(1, -2)
		elseif tonumber(key) or key == "." then
			resistance_input = resistance_input .. key
		elseif key == "escape" then
			setting_resistance = false
			resistance_input = ""
		end
	end
end
