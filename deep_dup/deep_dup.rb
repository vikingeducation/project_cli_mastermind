class Array
	def deep_dup
		a = []
		each do |i|
			if i.is_a?(Array)
				a << i.deep_dup
			else
				a << i
			end
		end
		a
	end
end