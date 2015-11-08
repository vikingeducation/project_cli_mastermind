class Board

  def initialize(max_guesses)
    @max_guesses = max_guesses
    @guesses = []
    @feedbacks = []
  end

  def render
    if @guesses.size > 0
      @guesses.each_with_index do |guess, index|
        puts "Guess #{index + 1}: #{guess}.  Feedback: #{@feedbacks[index]}"
      end
    else
      puts "No guesses yet!"
    end
  end

  def place_guess guess
    @guesses << guess
  end

end