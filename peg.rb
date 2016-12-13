require_relative 'constants'

class Peg
	def initialize(peg_line, num_pegs = 4)
		@peg_line = peg_line
		@num_pegs = num_pegs
	end

	def calculate_closeness(codeline)
		result = []
		peg_items_to_remove = []
		codeline_dup = []
		peg_line_dup = []
		num_black_pegs = 0
		num_white_pegs = 0
		codeline.each_with_index do |item, index|
			if codeline[index] == @peg_line[index]
				peg_items_to_remove[index] = true
				num_black_pegs += 1
			else
				peg_items_to_remove[index] = false
			end
		end
		peg_items_to_remove.each_with_index do |item, index|
			if !item
				codeline_dup << codeline[index]
				peg_line_dup << @peg_line[index]
			end
		end
		codeline_dup.each_with_index do |item, index|
			if peg_line_dup.include? item
				num_white_pegs += 1
			end
		end
		result[BLACK] = num_black_pegs
		result[WHITE] = num_white_pegs
		result[NO_COLOR]   = @num_pegs - num_black_pegs - num_white_pegs
		result
	end

	def self.print_closeness(result, new_line = nil)
		pegs     = ["・", "● ", "○ "]
		print  pegs[BLACK] * result[BLACK] + pegs[WHITE] * result[WHITE] + pegs[NO_COLOR] * result[NO_COLOR] + new_line.to_s
	end

	def self.print_pegs(line)
		pegs_hash = {
						A: "⚽  ",
						B: "🏀  ",
						C: "🏈  ",
						D: "🎾  ",
						E: "🏐  ",
						F: "🏉  ",
						G: "🎱  "
					}
		line.each do |item|
			print pegs_hash[item.to_sym]
		end
		print "\n"
	end
end
