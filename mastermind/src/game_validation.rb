class GameValidation < Validation
	def valid_role?(value)
		if ['1', '2'].include?(value)
			return true
		else
			@error = "Invalid role: #{value.to_i.to_s}"
			return false
		end
	end

	def valid_color?(value)
		if '123456'.split('').include?(value)
			return true
		else
			@error = "Invalid color: #{value.to_i.to_s}"
			return false
		end
	end

	def valid_code?(value)
		inside_range = value.chars.select {|c| c.to_i.between?(1, 6)}
		desired_length = 4
		if inside_range.length == value.chars.length && inside_range.length == desired_length
			return true
		else
			@error = "Invalid code: #{value.to_i.to_s}"
			return false
		end
	end
end