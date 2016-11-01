class Board 

	MAX_TURNS = 12
	WRONG = Rainbow("O").red
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
  	feedback = choice.dup
  	add_feedback( populate_feedback(feedback) )    
  end

  def code_guessed?
  	@board_guesses.last == @code
  end

  def full?
  	@turn_count == MAX_TURNS
  end

  private

	  def populate_feedback(choice)  	
	  	code_to_check = @code.dup
	  	choice, code = find_green_pegs(choice, code_to_check)
	  	choice, code = find_yellow_pegs(choice, code)
	  	final_feedback = find_red_pegs(choice, code)
	  	final_feedback
	  end

	  def find_green_pegs(choice, code_to_check)
	  	choice.each_with_index do |letter, index|
	  		if code_to_check[index] == letter
	  			choice[index] = CORRECT
	  			code_to_check[index] = '*'
        end
	  	end
	    return choice, code_to_check
	  end

	  def find_yellow_pegs(choice, code_to_check)
	  	choice.each_with_index do |letter, index|
	  		next if letter == CORRECT
	  		if code_to_check.include? letter
	  			choice[index] = CORRECT_LETTER
	  			change_index = code_to_check.find_index { |l| l == letter }
	  			code_to_check[change_index] = '*'
        end
	  	end
	    return choice, code_to_check
	  end

	  def find_red_pegs(choice, code_to_check)
	  	choice.each_with_index do |letter, index|
	  		next if letter == CORRECT 
	  		next if letter == CORRECT_LETTER
	  		choice[index] = WRONG
	  	end
	  	choice
	  end

	  def add_feedback(feedback)
	  	@board_feedback << feedback
	  end
end





































