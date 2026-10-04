function print_r(t)
	local print_r_cache = {}
	local function sub_print_r(value, indent)
		if print_r_cache[tostring(value)] then
			print(indent .. "*" .. tostring(value))
		else
			print_r_cache[tostring(value)] = true
			if type(value) == "table" then
				for pos, val in pairs(value) do
					if type(val) == "table" then
						print(indent .. "[" .. pos .. "] => " .. tostring(value) .. " {")
						sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
						print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
					else
						print(indent .. "[" .. pos .. "] => " .. tostring(val))
					end
				end
			else
				print(indent .. tostring(value))
			end
		end
	end
	sub_print_r(t, "  ")
end
