local imgui = require("imgui")

-- Resistor
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

-- Scale units
local voltage_scale_units = {
	V = 1,
	mV = 0.001,
	kV = 1000,
}

local current_scale_units = {
	A = 1,
	mA = 0.001,
	kA = 1000,
}

local resistance_scale_units = {
	OM = 1,
	mOM = 0.001,
	kOM = 1000,
}

local conduction_scale_units = {
	S = 1,
	mS = 0.001,
	kS = 1000,
}

local showTestWindow = false
local showAnotherWindow = false
local floatValue = 0;
local sliderFloat = { 0.1, 0.5 }
local clearColor = { 0.2, 0.2, 0.2 }
local comboSelection = 1
local textValue = "text"

function love.load(arg)
	imgui.SetReturnValueLast(false)
end

function love.update(dt)
	imgui.NewFrame()
end

function love.draw()
	local status

	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu("File") then
			imgui.MenuItem("Test")
			imgui.EndMenu()
		end
		imgui.EndMainMenuBar()
	end
	imgui.Text("Hello, world!")
    status, clearColor[1], clearColor[2], clearColor[3] = imgui.ColorEdit3("Clear color", clearColor[1], clearColor[2], clearColor[3])

	imgui.Render()
end
