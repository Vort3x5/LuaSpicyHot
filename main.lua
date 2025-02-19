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
	k = 1000,
	M = 1000000,
}

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GRID_SIZE = 10

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })

	-- background color: gray
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
end

function love.update(dt)
end

function love.draw()
	DrawElement(640, 360, Cursor)
end

function DrawElement(x, y, Element)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(3)

	Element(x, y)
end

function DrawCursor(x, y)
	love.graphics.setColor(0, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.line(x, y, x + GRID_SIZE, y)
	love.graphics.line(x - GRID_SIZE, y, x, y)
	love.graphics.line(x, y, x, y + GRID_SIZE)
	love.graphics.line(x, y, x, y - GRID_SIZE)
end

function Resistor(x, y)
	love.graphics.line(x - GRID_SIZE, y, x + GRID_SIZE, y)
	love.graphics.line(x - GRID_SIZE, y, x - GRID_SIZE, y - 3*GRID_SIZE)
	love.graphics.line(x + GRID_SIZE, y, x + GRID_SIZE, y - 3*GRID_SIZE)
	love.graphics.line(x - GRID_SIZE, y - 3*GRID_SIZE, x + GRID_SIZE, y - 3*GRID_SIZE)
end
