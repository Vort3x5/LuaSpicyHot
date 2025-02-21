function InTable(arr, v)
	for _, i in ipairs(arr) do
		if i == v then
			return true
		end
	end
	return false
end
