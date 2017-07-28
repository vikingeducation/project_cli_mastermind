module Mastermind
  class GuessAnalyzer
    attr_reader :inexact_matches_count, :exact_matches_count

    def initialize(secret, guess)
      @secret = secret
      @guess = guess
    end

    def feedback
      pegs = []
      exact_matches_count.times { pegs << :red }
      inexact_matches_count.times { pegs << :white }
      pegs
    end

    def exact_matches_count
      count_with_index(@secret) do |value, index|
        value == @guess[index]
      end
    end

    def inexact_matches_count
      secret, guess, = remove_exact_matches
      secret.count { |value, _| remove_inexact_match(value, guess) }
    end

    private

    def remove_exact_matches
      secret = @secret.dup
      guess = @guess.dup

      secret.each_with_index do |value, index|
        if value == guess[index]
          secret[index] = nil
          guess[index] = nil
        end
      end

      return secret.compact, guess.compact
    end

    def remove_inexact_match(secret_value, guess)
      guess.detect.with_index do |value, index|
        if value == secret_value
          guess[index] = nil
          true
        end
      end
    end

    def count_with_index(array, &block)
      with_index(array).count(&block)
    end

    def with_index(array)
      array.each_with_index.to_a
    end
  end
end
