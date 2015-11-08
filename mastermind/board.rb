class Board

  def initialize(max_guesses)
    @max_guesses = max_guesses
    @guesses = []
    @feedbacks = []
  end

  def render
    if @guesses.size > 0
      @guesses.each_with_index do |guess, index|
        puts "Guess: #{guess}.  Feedback: #{@feedbacks[index]}"
      end
    end
  end

end