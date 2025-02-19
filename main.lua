 local love = require("love")

local resistors = {}

local function AddResistor(resistance, conduction, current, voltage)
	local resistor = {
		resistance = resistance or 1/conduction,
		conduction = conduction or 1/resistance,
		current = current or conduction*voltage,
		voltage = voltage or resistance*current
	}
	table.insert(resistors, resistor)
end

local scale_units = {
	n = 0,000001,
	m = 0.001,
	X = 1,
	k = 1000,
	M = 1000000,
}

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })

	-- background color: gray
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
end

function love.update(dt)
end

function love.draw()
	DrawGrid()
end

function DrawGrid()
    -- Set the grid color to black
    love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(2)

	grid_size = 10
    for x = 0, WINDOW_WIDTH, grid_size do
        love.graphics.line(x, 0, x, WINDOW_HEIGHT)
    end 

    for y = 0, WINDOW_HEIGHT, grid_size do
        love.graphics.line(0, y, WINDOW_WIDTH, y)
    end
end
