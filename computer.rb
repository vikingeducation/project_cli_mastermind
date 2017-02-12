class Computer
  attr_reader :code_colors
  attr_accessor :guess, :feedback, :remaining_guesses

  def initialize(code_colors)
    @guess = nil
    @feedback = nil
    @code_colors = code_colors
    @remaining_guesses = build_all_possible_permutations
  end

  def make_guess
    naive_random_guess
  end

  # build all possible permutations of 4 pegs from
  # the given set of code colors
  def build_all_possible_permutations
    code_colors.repeated_permutation(4).to_a
  end

  # kick-start the algorithm by using a first guess
  # of two pegs of two colors, e.g. red red blue blue
  def first_guess
    [code_colors[0], code_colors[0], code_colors[1], code_colors[1]]
  end

  # based on current feedback, remove all remaining guesses that would
  # not generate the same feedback
  def remove_wrong_guesses(mastermind)
    possible_correct_guesses = []
    remaining_guesses.each do |remaining_guess|
      feedback = mastermind.give_feedback(remaining_guess)
      
      possible_correct_guesses << remaining_guess if feedback == self.feedback
    end

    p possible_correct_guesses

    self.remaining_guesses = possible_correct_guesses
  end
end
