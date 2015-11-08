class Board

  def initialize(max_guesses)
    @max_guesses = max_guesses
    @guesses = []
    @feedbacks = []
    @valid_guesses = ['r', 'b', 'g', 'y', 'p', 'o']
  end

  def render
    puts '-' * 50
    if @guesses.size > 0
      @guesses.each_with_index do |guess, index|
        guess_print = ''
        guess.each{|g| guess_print += " #{g} |"}

        feedback_print = ''
        @feedbacks[index].each{|f| feedback_print += " #{f} "} if @feedbacks[index]

        puts "Guess #{index + 1}: |#{guess_print}  Feedback: #{feedback_print}"
      end
    else
      puts "No guesses yet!"
    end
    puts '-' * 50
  end

  def place_guess guess
    if valid_guess?(guess)
      @guesses << guess
      render
      true
    else
      false
    end
  end

  def valid_guess? guess
    if guess.select{|guess| @valid_guesses.include?(guess)}.size == 4
      true
    else
      puts "Hmm, I don't recognize those colors. Try again..."
    end
  end

end