#!/usr/bin/evn lua

local fltk = require("fltk4lua")

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
	X = 1,
	k = 1000,
	M = 1000000,
}

local window = fltk.Window(400, 300, arg[0])

local b = fltk.Box(10, 10, 300, 300, [[
MINIMUM UPDATE TEST]])
b.box = "FL_ENGRAVED_FRAME"
window.resizable = b

window:show(arg)
fltk.run()
