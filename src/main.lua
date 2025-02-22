local love     = require("love")
local logic    = require("logic")
local settings = require("settings")
local utils    = require("utils")
local draw     = require("draw")

function love.load()
	love.window.setTitle("LuaSpicyHot")
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { fullscreen = false })
    love.graphics.setBackgroundColor(BACKGROUND_COLOR)

	AddSprite(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, Cursor)
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
	if key == "escape" or key == 'q' then
		love.event.quit()
	end

	local cursor = sprites[1]
	if key == "space" then
		AddSprite(cursor.x, cursor.y, Resistor)
	end
end

function love.draw()
	love.graphics.clear(BACKGROUND_COLOR)
	for i, sprite in ipairs(sprites) do
		DrawElement(sprite.x, sprite.y, sprite.draw)
	end
end
