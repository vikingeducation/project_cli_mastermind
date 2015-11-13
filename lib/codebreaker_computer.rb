class CodebreakerComputer < Codebreaker

  def initialize(name, board)
    super(name, board)
    @set_possible_guesses = (VALID_GUESSES * 4).permutation(4).to_a
  end

  def get_guess
    if @board.guesses.empty?
      current_guess = ['r', 'r', 'g', 'g']
    elsif @set_possible_guesses.size == 1
      current_guess = @set_possible_guesses.first
    else
      @set_possible_guesses.select! do |guess|
        @board.feedbacks.last == feedback_algorithm(@board.guesses.last.deep_dup, guess.deep_dup)
      end
      # Uncomment below to see the AI in action
      # puts @set_possible_guesses.size
      # @set_possible_guesses.each{|guess| print "#{guess.join}, "}
      current_guess = @set_possible_guesses.sample
    end
    @set_possible_guesses.delete(current_guess)
    @board.place_guess(current_guess)
  end
end