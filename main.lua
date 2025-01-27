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

local function ParseParams(input)
	local value, unit = input:match("^(%d+%.?%d*)([a-zA-Z]+)$")
	print(value)
	if value then
		value = tonumber(value)

		if voltage_scale_units[unit] then
			return value*voltage_scale_units[unit], "voltage"
		elseif current_scale_units[unit] then
			return value*current_scale_units[unit], "current"
		elseif resistance_scale_units[unit] then
			return value*resistance_scale_units[unit], "resistance"
		elseif conduction_scale_units[unit] then
			return value*conduction_scale_units[unit], "conduction"
		else
			error("Unknown unit: " .. unit)
		end
	else
		error("Invalid parameter format" .. input)
	end
end

local function Shell()
	while true do
		print("1. Add resistor")
		print("2. List resistors")
		print("3. Exit")
		local choice = tonumber(io.read())

		if choice == 1 then
			io.write("Pass Resistor parameters: ")
			input = io.read()
			ParseParams(input)
		elseif choice == 3 then
			break
		end
	end
end

Shell()
