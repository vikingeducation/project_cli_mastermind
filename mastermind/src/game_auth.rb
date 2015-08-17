class GameAuth < Auth
	def valid_role?(role)
		if ['1', '2'].include?(role)
			return true
		else
			@error = "Invalid role: #{role.to_i.to_s}"
			return false
		end
	end

	def valid_guess?(guess)
		if '123456'.split('').include?(guess)
			return true
		else
			@error = "Invalid guess: #{guess.to_i.to_s}"
			return false
		end
	end
end