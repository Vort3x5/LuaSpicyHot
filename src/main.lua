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
	if love.keyboard.isDown("lshift") and key == "r" then
		AddSprite(cursor.x, cursor.y, Resistor)
	elseif key == "space" and InSprite(cursor.x, cursor.y) > 0 then
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
		DrawElement(sprite.x, sprite.y, sprite.draw)
		FillSpriteID(sprite.x, sprite.y, i - 1) -- don't fill for cursor
	end
end
