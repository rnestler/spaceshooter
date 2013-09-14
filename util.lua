
function clamp(val, min, max)
	if val<min then
		val=min
	elseif val>max then
		val=max
	end
	return val
end
