local love     = require("love")
local logic    = require("logic")
local settings = require("settings")
local utils    = require("utils")
local draw     = require("draw")

modifying = false
element = 0

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)
	AddNode(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, Cursor, 0)
	modifying = false
end

function love.update(dt)
	local cursor = sprites[1]

	-- hung cursor if currently modifying
	if modifying then
	elseif love.keyboard.isDown(LEFT_KEYS) then
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
		local start_x, start_y = cursor.x, cursor.y
		if InTable(FLAT_DEGREES, element.angle) then
			if InTable(LEFT_KEYS, key) then
				cursor.x, cursor.y = element.x - 1.5*GRID_SIZE, element.y
			elseif InTable(RIGHT_KEYS, key) then
				cursor.x, cursor.y = element.x + 1.5*GRID_SIZE, element.y
			end
		else
			if InTable(DOWN_KEYS, key) then
				cursor.x, cursor.y = element.x, element.y + 1.5*GRID_SIZE
			elseif InTable(UP_KEYS, key) then
				cursor.x, cursor.y = element.x, element.y - 1.5*GRID_SIZE
			end
		end
		if start_x ~= cursor.x or start_y ~= cursor.y then
			start_x, start_y = cursor.x, cursor.y
			-- AddEdge(start_x, start_y, Wire)
		end
	end

	if love.keyboard.isDown("lshift") and key == "r" then
		AddNode(cursor.x, cursor.y, Resistor, 0)
	elseif key == "space" then
		id = InSprite(cursor.x, cursor.y)
		print(id)
		if id ~= 0 then
			element = sprites[id]
			modifying = true
			print(modifying)
		end
	end
end

function love.draw()
	for y=1, WINDOW_HEIGHT do
		for x=1, WINDOW_HEIGHT do
			elements_on_screen[(y - 1)*WINDOW_WIDTH + x] = 0
		end
	end
	love.graphics.clear(BACKGROUND_COLOR)

	for i, sprite in ipairs(sprites) do
		DrawElement(sprite.x, sprite.y, sprite.draw, sprite.angle)
		if i > 1 then
			FillNodeID(sprite.x, sprite.y, i) -- don't fill for cursor
		end
	end
end
