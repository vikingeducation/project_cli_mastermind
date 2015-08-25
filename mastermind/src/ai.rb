require_relative 'board.rb'

class AI
	def self.color
		random_color.to_s
	end
	
	def self.guess
		random_code
	end

	def self.code
		random_code
	end

	private
		def self.random_color
			rand(1..Board::COLORS)
		end

		def self.random_code
			code = []
			4.times do
				code << random_color
			end
			code.join
		end
end