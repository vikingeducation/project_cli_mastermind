class Board
  attr_reader :guesses

  @@valid_guesses = ['r', 'b', 'g', 'y', 'p', 'o']

  def initialize
    @guesses = []
    @feedbacks = []
  end

  def render
    puts "\nCurrent Board:"
    puts '-' * 50
    if @guesses.size > 0
      @guesses.each_with_index do |guess, index|
        guess_print = ' '
        guess.each{|g| guess_print += " #{g} "}

        feedback_print = ''
        @feedbacks[index].each{|f| feedback_print += " #{f} "} if @feedbacks[index]

        puts " Guess #{index + 1}: #{guess_print}  |  Feedback: #{feedback_print} "
      end
    else
      puts "No guesses yet!"
    end
    puts '-' * 50
  end

  def place_guess guess
    if valid_guess?(guess)
      @guesses << guess
      true
    else
      false
    end
  end

  def valid_guess? guess
    if guess.select{|guess| @@valid_guesses.include?(guess)}.size == 4
      true
    else
      puts "Hmm, I don't recognize those colors. Try again..."
    end
  end

  def place_feedback feedback
    @feedbacks << feedback
  end

  def winning_guess?
    @feedbacks.last == Array.new(4, '*')
  end

end