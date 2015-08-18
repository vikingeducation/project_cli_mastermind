class AI
	@@outcomes

	def self.color
		random_color.to_s
	end
	
	def self.code
		code = []
		4.times do
			code << random_color
		end
		code
	end

	private
		def self.random_color
			rand(1..Board::COLORS)
		end
end