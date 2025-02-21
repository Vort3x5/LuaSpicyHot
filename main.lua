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
BACKGROUND_COLOR = { 0.2, 0.2, 0.2 } -- gray
GRID_SIZE = 10

LEFT_KEYS  = {"left", "a", "h", "m"}
DOWN_KEYS  = {"down", "s", "j", "n"}
UP_KEYS    = {"up", "w", "k", "e"}
RIGHT_KEYS = {"right", "d", "l", "i"}

sprites = {}

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)

	cursor = { x = WINDOW_WIDTH / 2, y = WINDOW_HEIGHT / 2 }
	table.insert(sprites, cursor)
end

function love.update(dt)
end

function love.keypressed(key)
	if key == "escape" or key == 'q' then
		love.event.quit()
	end
end

function love.draw()
	DrawElement(640, 360, Cursor)
	love.graphics.clear(BACKGROUND_COLOR)
end

function DrawElement(x, y, Element)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(3)

	Element(x, y)
end

function UndrawElement(x, y ,Element)
	love.graphics.setColor(BACKGROUND_COLOR)
	love.graphics.setLineWidth(3)

	Element(x, y)
end

function Cursor(x, y)
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
