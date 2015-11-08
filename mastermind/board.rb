class Board
  include DataIO

  attr_reader :guesses
  @@valid_guesses = ['r', 'b', 'g', 'y', 'p', 'o']
  @@valid_feedbacks = ['*', '+']

  def initialize
    @guesses = []
    @feedbacks = []
  end

  def render
    puts "\nCurrent Board:"
    puts '-' * 50
    if @guesses.size > 0
      @guesses.each_with_index do |guess, index|
        output =
        puts " Guess #{index + 1}: #{guess.join(' ')}  |  Feedback: #{@feedbacks[index].join(' ') if @feedbacks[index]} "
      end
    else
      puts "No guesses yet!"
    end
    puts '-' * 50
  end

  def place_guess guess
    if valid_entries?(guess, @@valid_guesses)
      @guesses << guess
      true
    else
      false
    end
  end

  def place_feedback feedback
    if valid_entries?(feedback, @@valid_feedbacks)
      @feedbacks << feedback
      true
    else
      false
    end
  end

  def winning_guess?
    @feedbacks.last == Array.new(4, '*')
  end

end