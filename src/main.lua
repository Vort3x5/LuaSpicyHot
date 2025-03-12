local love     = require("love")
local logic    = require("logic")
local utils    = require("utils")
local draw     = require("draw")
local handlers = require("handlers")
local graphs   = require("graphs")

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

L, D, U, R = 1, 2, 3, 4

sprites = {}
wires = {}
elements_on_screen = {}
circuits = {}

modifying = false
from_wire = {
	state = false,
	x = 0,
	y = 0,
}
drawing_wire = {
	state = false,
	start_x = 0,
	start_y = 0,
	dir = 0,
	id = 0,
}

curr_circuit = 1
element = 0
cursor = {}

dbg = false

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
	ClearIDs()
	AddNode(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, Cursor, 0)
	modifying = false
	ResetWiring()
	cursor = sprites[1]
end

function love.update(dt)
	if love.keyboard.isDown(LEFT_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == L) then
		cursor.x = cursor.x - 2
	elseif love.keyboard.isDown(DOWN_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == D) then
		cursor.y = cursor.y + 2
	elseif love.keyboard.isDown(UP_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == U) then
		cursor.y = cursor.y - 2
	elseif love.keyboard.isDown(RIGHT_KEYS) 
	and (not drawing_wire.state or drawing_wire.dir == R) then
		cursor.x = cursor.x + 2
	end
end

function love.keypressed(key)
	if key == 'q' then
		love.event.quit()
	end

	if key == "escape" then 
		ExitMod()
	end

	if love.keyboard.isDown("lshift") and key == "r" then
		AddNode(cursor.x, cursor.y, Resistor, 0)
	elseif key == "space" and not modifying then
		modifying = true
		local id = InSprite(cursor.x, cursor.y)
		print(id)
		if id > 0 then
			SetModElement()
		elseif id < 0 then
			SetModWire()
		end
	elseif key == 'return' and drawing_wire.state then
		AddEdge(
		   drawing_wire.start_x, drawing_wire.start_y,
           cursor.x, cursor.y,
		   drawing_wire.dir, drawing_wire.id or 0
		)
		local id = InSprite(cursor.x, cursor.y)
		if id > 0 then
			-- AddV(curr_circuit, src?, id)
		end
		ExitMod()
	end

	if modifying and not from_wire.state then
		if key == 'r' then
			Rotate()
		end
		WireFromElement(key)
	elseif modifying and from_wire.state then
		WireFromWire(key)
	end

	if key == "y" then
		dbg = not dbg
	end
end

function love.draw()
	-- ClearIDs()
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
		if wire.id == 0 then
			wire.id = -i
		end
		FillEdgeID(wire.start_x, wire.start_y, wire.end_x, wire.end_y, wire.direction, wire.id)
	end

	local cursor = sprites[1]
	if modifying and drawing_wire.state then
		DrawWire(
			drawing_wire.start_x, drawing_wire.start_y,
			cursor.x, cursor.y
		)
	end
	if dbg then
		DebugIDs()
	end
end
