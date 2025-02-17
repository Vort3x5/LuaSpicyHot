#!/usr/bin/evn lua

local fltk = require("fltk4lua")

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

local window = fltk.Window(400, 300, arg[0])

local b = fltk.Box(10, 10, 300, 300, [[
MINIMUM UPDATE TEST]])
b.box = "FL_ENGRAVED_FRAME"
window.resizable = b

window:show(arg)
fltk.run()
