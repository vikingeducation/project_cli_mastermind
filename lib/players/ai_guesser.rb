module Mastermind
  class AIGuesser
    def initialize
      @first_guess = [:blue, :blue, :yellow, :yellow]
      @guesses = Board::COLORS.repeated_permutation(Board::ROW_SIZE).to_a - @first_guess
    end

    def guess(last_guess_hash)
      return @first_guess unless last_guess_hash

      reduce_guesses(last_guess_hash)
      @guesses.shuffle.pop
    end

    private

    def reduce_guesses(last_guess)
      @guesses.select! do |guess|
        analyzer = GuessAnalyzer.new(guess, last_guess[:guess])
        analyzer.feedback.sort == last_guess[:feedback].sort
      end
    end
  end
end
