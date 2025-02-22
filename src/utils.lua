function InTable(arr, v)
	for _, i in ipairs(arr) do
		if i == v then
			return true
		end
	end
	return false
end

function AddSprite(pos_x, pos_y, draw_func)
	table.insert(sprites, { x = pos_x, y = pos_y, draw = draw_func })
end
