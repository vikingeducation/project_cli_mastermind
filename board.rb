class Board

	MAX_TURNS = 12
	CORRECT_LETTER = Rainbow("O").yellow
	CORRECT = Rainbow("O").green

	attr_accessor :code

	def initialize
		@code = nil
		@board_guesses = []
		@board_feedback = []
		@turn_count = 0
	end

	def render
		Renderer.render_board(@board_guesses, @board_feedback)
	end

	def add_choice(choice)
		@board_guesses << choice
		@turn_count += 1
		add_feedback( populate_feedback(choice) )
	end

	def code_guessed?
		@board_guesses.last == @code
	end

	def full?
		@turn_count == MAX_TURNS
	end

	private

	def populate_feedback(choice)
		code_to_check = code.dup
		pairs = choice.zip(code_to_check)

		green_pegs, unmatched_pairs = find_green_pegs(pairs)
		yellow_pegs = find_yellow_pegs(unmatched_pairs)

		green_pegs + yellow_pegs
	end

	def find_green_pegs( guess_pairs )
		unmatched_pairs = guess_pairs.select do |pair|
			pair[0] != pair[1]
		end

		green_pegs = []
		(guess_pairs.length - unmatched_pairs.length).times do
			green_pegs << CORRECT
		end

		return green_pegs, unmatched_pairs
	end

	def find_yellow_pegs(pairs)
		choice_left, code_left = pairs.transpose
		yellow_pegs = []

		choice_left.each do |peg|
			if code_left.include? peg
				yellow_pegs << CORRECT_LETTER
				#li[li.length] is out of range, so the
				# || li.length handles the case where n isn't in the list.
				code_left.delete_at(code_left.index(peg) || code_left.length)
			end
		end

		yellow_pegs
	end

	def add_feedback(feedback)
		@board_feedback << feedback
	end
end
