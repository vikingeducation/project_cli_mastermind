class Board 

	MAX_TURNS = 12
	WRONG = 0
	CORRECT_LETTER = 1
	CORRECT = 2

  attr_accessor :code

  def initialize
    @code = nil
    @board_guesses = []
    @board_feedback = []
    @turn_count = 0
  end

  def render
    # Guesses    | Feedback
    # 1. A B D C | 0 0 1 2
    # 2. 
    unless @board_guesses.empty?
      puts "   Guesses | Feedback"
      @board_guesses.each_with_index do |guess, index|
        print "#{index + 1}. "
        print "#{guess.join(" ")}"
        print " | "
        print "#{@board_feedback[index].join(" ")}"
        puts
      end
    end
  end

  def add_choice(choice)
  	@board_guesses << choice
  	@turn_count += 1
  	add_feedback( generate_feedback(choice) )    
  end

  def generate_feedback(choice)
  	feedback = []

  	choice.each_with_index do |letter, index|
  		if @code[index] == letter
  			feedback << CORRECT
  		elsif @code.include? letter
  			feedback << CORRECT_LETTER
  		else
  			feedback << WRONG
  		end
  	end
    feedback
  end

  def add_feedback(feedback)
  	@board_feedback << feedback
    puts "feedback: #{feedback} , #{@board_feedback}"
  end

  def victory?
  	@board_guesses.last == @code
  end

  def loss?
  	@turn_count == MAX_TURNS
  end
end


