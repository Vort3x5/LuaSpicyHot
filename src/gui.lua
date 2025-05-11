local gui = {}

local font = love.graphics.newFont(14)

local function drawKeybinding(x, y, title, keys)
	love.graphics.print(title, x, y)
	for i, key in ipairs(keys) do
		love.graphics.print("- " .. key, x + 20, y + i * 20)
	end
end

function gui.DrawMenu(modifying, from_wire)
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
			"R - insert resistor",
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
				"Escape - leave 'modfification' mode"
			}
			for i, k in ipairs(keys) do
				love.graphics.print(k, x + 20, y + i * line_height)
			end
		else
			love.graphics.print("Modification mode (resistor):", x, y)
			local keys = {
				"R - rotate",
				"V - set value",
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

return gui
