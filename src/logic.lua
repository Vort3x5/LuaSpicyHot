resistors = {}

function AddResistor(resistance, conduction, current, voltage)
	local resistor = {
		resistance = resistance or 1/conduction,
		conduction = conduction or 1/resistance,
		current = current or conduction*voltage,
		voltage = voltage or resistance*current
	}
	table.insert(resistors, resistor)
end

scale_units = {
	n = 0,000001,
	m = 0.001,
	k = 1000,
	M = 1000000,
}
