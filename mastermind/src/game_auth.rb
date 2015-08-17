class GameAuth < Auth
	def valid_role?(role)
		if ['1', '2'].include?(role)
			return true
		else
			@error = "Invalid role: #{role.to_i.to_s}"
			return false
		end
	end

	def valid_color?(color)
		if '123456'.split('').include?(color)
			return true
		else
			@error = "Invalid color: #{color.to_i.to_s}"
			return false
		end
	end
end