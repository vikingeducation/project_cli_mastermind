def deep_dupe(arr)

	new_arr = []

	arr.each do |x|
		new_arr << x.dup
	end

	new_arr

end