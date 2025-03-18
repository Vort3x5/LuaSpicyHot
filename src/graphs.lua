function InitGraph()
	for i = 1, 20 do
		circuits[i] = {}
	end
end

function AddV(src, dest)
	table.insert(circuits[src], dest)
	table.insert(circuits[dest], src)
end
