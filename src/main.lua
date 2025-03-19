local love     = require("love")
local utils    = require("utils")
local draw     = require("draw")
local handlers = require("handlers")
local graphs   = require("graphs")

WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 720

BACKGROUND_COLOR = { 0.2, 0.2, 0.2 } -- gray

GRID_SIZE = 10

LEFT_KEYS    = {"left", "h", "m"}
DOWN_KEYS    = {"down", "j", "n"}
UP_KEYS      = {"up", "k", "e"}
RIGHT_KEYS   = {"right", "l", "i"}
ELEMENT_KEYS = {"escape", "r"}

FLAT_DEGREES = {90, 270}

L, D, U, R = 1, 2, 3, 4

SCALE_UNITS = {
	n = 0,000001,
	m = 0.001,
	k = 1000,
	M = 1000000,
}

sprites            = {}
wires              = {}
elements_on_screen = {}
circuits           = {}
resistors          = {}
junctions          = {}

modifying = false
from_wire = {
	state = false,
	x = 0,
	y = 0,
	src = 0,
}
drawing_wire = {
	state = false,
	start_x = 0,
	start_y = 0,
	dir = 0,
	id = 0,
}

curr_circuit = 1
curr_wire = 0
element = 0
cursor = {}

node_count = 0

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
	InitCircuit()
	resistors[1] = 0
end

function love.update(dt)
	CursorMovement()
end

function love.keypressed(key)
	if key == 'q' then
		love.event.quit()
	end

	if key == "escape" then 
		ExitMod()
	end

	local id = InSprite(cursor.x, cursor.y)
	if love.keyboard.isDown("lshift") and key == 'r' then
		AddNode(cursor.x, cursor.y, Resistor, 0)
	elseif key == "space" and not modifying then
		modifying = true
		if id > 0 then
			SetModElement(id)
		elseif id < 0 then
			SetModWire(id)
		else
			modifying = false
		end
	elseif key == 'v' and id > 0 then
		SetResistance(id, 5)
	elseif key == "return" and drawing_wire.state then
		AddEdge(
		   drawing_wire.start_x, drawing_wire.start_y,
		   cursor.x, cursor.y,
		   drawing_wire.dir, drawing_wire.id or 0
		)
		if id and id > 0 then
			WireAddNode(drawing_wire.id, id)
		end
		ExitMod()
	elseif love.keyboard.isDown("lshift") and key == 's' then
		BuildCircuit()
		SolveCircuit()
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
		-- print(elements_on_screen[(cursor.y - 1)*WINDOW_WIDTH + cursor.x])
		PrintCircuit()
	end
end

function love.draw()
	ClearIDs()
	love.graphics.clear(BACKGROUND_COLOR)

	for i, wire in ipairs(wires) do
		DrawWire(wire.start_x, wire.start_y, wire.end_x, wire.end_y)
		if wire.id == 0 then
			wire.id = -i
		end
		FillEdgeID(wire.start_x, wire.start_y, wire.end_x, wire.end_y, wire.direction, wire.id)
	end
	for i, sprite in ipairs(sprites) do
		DrawElement(sprite.x, sprite.y, sprite.draw, sprite.angle)
		if i > 1 then
			FillNodeID(sprite.x, sprite.y, i)
		end
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
