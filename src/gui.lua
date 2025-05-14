local font = love.graphics.newFont(14)

local function drawKeybinding(x, y, title, keys)
	love.graphics.print(title, x, y)
	for i, key in ipairs(keys) do
		love.graphics.print("- " .. key, x + 20, y + i * 20)
	end
end

function DrawMenu(modifying, from_wire)
	love.graphics.setFont(font)
	love.graphics.setColor(1, 1, 1, 1)

	local x = 20
	local y = 20
	local line_height = 20

	if not modifying then
		love.graphics.print("Normal mode:", x, y)
		local keys = {
			"W - up",
			"S - down",
			"A - left",
			"D - right",
			"ENTER - place wire",
			"R - add resistor",
			"V - set value",
			"Q - Quit",
			"Space - modify"
		}
		for i, k in ipairs(keys) do
			love.graphics.print(k, x + 20, y + i * line_height)
		end
	else
		if from_wire then
			love.graphics.print("Modification mode (wire):", x, y)
			local keys = {
				"W -  wire up",
				"S -  wire down",
				"A -  wire left",
				"D -  wire right",
				"ENTER - place wire",
				"Escape - leave 'modfification' mode"
			}
			for i, k in ipairs(keys) do
				love.graphics.print(k, x + 20, y + i * line_height)
			end
		else
			love.graphics.print("Modification mode (resistor):", x, y)
			local keys = {
				"R - rotate",
				"W - wire up (if vertical)",
				"S - wire down (if vertical)",
				"A - wire left (if horizontal)",
				"D - wire right (if horizontal)",
				"Escape - leave 'modufication' mode"
			}
			for i, k in ipairs(keys) do
				love.graphics.print(k, x + 20, y + i * line_height)
			end
		end
	end
end

function DrawPopUp() 
	love.graphics.setColor(0.1, 0.1, 0.1, 0.9)
	local popup_width = 300
	local popup_height = 100
	local popup_x = (WINDOW_WIDTH - popup_width) / 2
	local popup_y = (WINDOW_HEIGHT - popup_height) / 2
	
	love.graphics.rectangle("fill", popup_x, popup_y, popup_width, popup_height)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("line", popup_x, popup_y, popup_width, popup_height)
	
	love.graphics.print("Enter resistance value:", popup_x + 20, popup_y + 20)
	love.graphics.print(resistance_input, popup_x + 20, popup_y + 50)
	love.graphics.print("Press Enter to confirm, Esc to cancel", popup_x + 20, popup_y + 70)
end
