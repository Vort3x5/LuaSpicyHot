local love     = require("love")
local logic    = require("logic")
local settings = require("settings")
local utils    = require("utils")
local draw     = require("draw")

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)

	local cursor = { x = WINDOW_WIDTH / 2, y = WINDOW_HEIGHT / 2, draw = Cursor }
	table.insert(sprites, cursor)
end

function love.update(dt)
end

function love.keypressed(key)
	if key == "escape" or key == 'q' then
		love.event.quit()
	end

	local cursor = sprites[1]
	if InTable(LEFT_KEYS, key) then
		cursor.x = cursor.x - GRID_SIZE
	elseif InTable(DOWN_KEYS, key) then
		cursor.y = cursor.y + GRID_SIZE
	elseif InTable(UP_KEYS, key) then
		cursor.y = cursor.y - GRID_SIZE
	elseif InTable(RIGHT_KEYS, key) then
		cursor.x = cursor.x + GRID_SIZE
	end
end

function love.draw()
	love.graphics.clear(BACKGROUND_COLOR)
	DrawElement(0, 0, Cursor)
	for i, sprite in ipairs(sprites) do
		DrawElement(sprite.x, sprite.y, sprite.draw)
	end
end
