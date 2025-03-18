function ResistorsSeries(r1, r2)
	return r1 + r2
end

function ResistorsParallel(r1, r2)
	return (r1 * r2)/(r1 + r2)
end

function InitCircuit()
	for i = 1, 20 do
		circuits[i] = {}
		circuits[i].mx = 0
	end
	for i = 1, 20 do
		junctions[i] = {}
	end
end

function WireAddNode(edge, node)
	table.insert(junctions[-edge], node)
end

function CircuitAddNode(src, dest)
	table.insert(circuits[src], dest)
	circuits[src].mx = Max(circuits[src].mx, dest)
	Sort(circuits[src])
end

function BuildCircuit()
	for _, junction in ipairs(junctions) do
		for _, src in ipairs(junction) do
			for _, dest in ipairs(junction) do
				if src ~= dest then
					CircuitAddNode(src, dest)
				end
			end
		end
	end
end

function PrintCircuit()
	for v = 2, node_count do
		for _, q in ipairs(circuits[v]) do
			print(v .. ": " .. q .. " ")
		end
	end
end

function SolveCircuit()
end
