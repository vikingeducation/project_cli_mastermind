require_relative 'peg'

class Board
	def initialize
		@codelines        = []
		@peg_lines_result = []
	end
	def add_round(codeline, peg_line_result)
		@codelines        << codeline
		@peg_lines_result << peg_line_result
	end
	def render
		@codelines.each_with_index do |item, index|
			print "Round #{index + 1} :          ".rjust(30)
			Peg.print_closeness(@peg_lines_result[index], "    ")
			Peg.print_pegs(item)
		end
	end
end