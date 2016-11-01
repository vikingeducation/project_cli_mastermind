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
  	add_feedback( generate_feedback(choice) )    
  end

  def code_guessed?
  	@board_guesses.last == @code
  end

  def full?
  	@turn_count == MAX_TURNS
  end

  private

	  def generate_feedback(choice)
	  	feedback = []
      code_to_check = @code.dup
	  	choice.each_with_index do |letter, index|
	  		if code_to_check[index] == letter
	  			feedback << CORRECT
          code_to_check[index] = '#'
	  		elsif code_to_check.include?(letter)
	  			feedback << CORRECT_LETTER
          change_index = code_to_check.find_index { |char| char == letter }
          code_to_check[change_index] = '#'
	  		else
	  			feedback << WRONG
	  		end
	  	end
	    feedback
	  end

	  def add_feedback(feedback)
	  	@board_feedback << feedback
	  end
end


