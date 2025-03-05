local love  = require("love")
local logic = require("logic")
local utils = require("utils")
local draw  = require("draw")

WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 720

BACKGROUND_COLOR = { 0.2, 0.2, 0.2 } -- gray

GRID_SIZE = 10

LEFT_KEYS    = {"left", "a", "h", "m"}
DOWN_KEYS    = {"down", "s", "j", "n"}
UP_KEYS      = {"up", "w", "k", "e"}
RIGHT_KEYS   = {"right", "d", "l", "i"}
ELEMENT_KEYS = {"escape", "r"}

FLAT_DEGREES = {90, 270}

sprites = {}
wires = {}
elements_on_screen = {}

modifying = false
drawing_wire = {
	state = false,
	start_x = 0,
	start_y = 0,
	dir = 0
}

element = 0

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
	AddNode(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, Cursor, 0)
	modifying = false
	ResetWiring()
end

function love.update(dt)
	local cursor = sprites[1]

	if love.keyboard.isDown(LEFT_KEYS) then
		cursor.x = cursor.x - 2
	elseif love.keyboard.isDown(DOWN_KEYS) then
		cursor.y = cursor.y + 2
	elseif love.keyboard.isDown(UP_KEYS) then
		cursor.y = cursor.y - 2
	elseif love.keyboard.isDown(RIGHT_KEYS) then
		cursor.x = cursor.x + 2
	end
end

function love.keypressed(key)
	if key == 'q' then
		love.event.quit()
	end

	local cursor = sprites[1]
	if key == "escape" then 
		element = 0
		modifying = false
	end
	if modifying then
		if key == 'r' then
			element.angle = (element.angle + 90) % 360
		end
		local start_x, start_y, dir = cursor.x, cursor.y, 0
		if InTable(FLAT_DEGREES, element.angle) then
			if InTable(LEFT_KEYS, key) then
				cursor.x, cursor.y = element.x - 1.5*GRID_SIZE, element.y
				dir = 1
			elseif InTable(RIGHT_KEYS, key) then
				cursor.x, cursor.y = element.x + 1.5*GRID_SIZE, element.y
				dir = 4
			end
		else
			if InTable(DOWN_KEYS, key) then
				cursor.x, cursor.y = element.x, element.y + 1.5*GRID_SIZE
				dir = 2
			elseif InTable(UP_KEYS, key) then
				cursor.x, cursor.y = element.x, element.y - 1.5*GRID_SIZE
				dir = 3
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

	if love.keyboard.isDown("lshift") and key == "r" then
		AddNode(cursor.x, cursor.y, Resistor, 0)
	elseif key == "space" and not modifying then
		id = InSprite(cursor.x, cursor.y)
		print(id)
		if id ~= 0 then
			element = sprites[id]
			modifying = true
		end
	elseif key == 'return' and drawing_wire.state then
		AddEdge(
		   drawing_wire.start_x, drawing_wire.start_y,
           cursor.x, cursor.y,
		   drawing_wire.dir
		)
		ResetWiring()
		modifying = false
	end
end

function love.draw()
	for y=1, WINDOW_HEIGHT do
		for x=1, WINDOW_HEIGHT do
			elements_on_screen[(y - 1)*WINDOW_WIDTH + x] = 0
		end
	end
	love.graphics.clear(BACKGROUND_COLOR)

	-- Move Filling IDs to keypress function, and use batching for sprites
	for i, sprite in ipairs(sprites) do
		DrawElement(sprite.x, sprite.y, sprite.draw, sprite.angle)
		if i > 1 then
			FillNodeID(sprite.x, sprite.y, i) -- don't fill for cursor
		end
	end
	for i, wire in ipairs(wires) do
		DrawWire(wire.start_x, wire.start_y, wire.end_x, wire.end_y)
		FillEdgeID(wire.start_x, wire.start_y, wire.end_x, wire.end_y, wire.direction, i)
	end

	local cursor = sprites[1]
	if modifying and drawing_wire.state then
		DrawWire(
			drawing_wire.start_x, drawing_wire.start_y,
			cursor.x, cursor.y
		)
	end
end
