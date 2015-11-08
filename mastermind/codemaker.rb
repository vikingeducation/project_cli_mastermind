class Codemaker
  # TODO: Not DRY since also in codebreaker
  @@valid_guesses = ['r', 'b', 'g', 'y', 'p', 'o']

  def initialize(allow_dups, board)
    @board = board

    # TODO make code more private?
    @code = get_code
    puts @code.to_s # TODO: delete this
  end

  def get_feedback
    guess = @board.guesses.last.deep_dup
    code_copy = @code.deep_dup
    feedback = []

    # Check correct color and position
    index = 0
    while index < guess.size
      if guess[index] == code_copy[index]
        feedback << '*'
        guess.delete_at(index)
        code_copy.delete_at(index)
      else
        index += 1
      end
    end

    # Check what's left for correct color in wrong position
    guess.each do |peg|
      if code_copy.include?(peg)
        feedback << '+'
        # Delete that one copy of the matching guess in the code copy
        code_copy.delete_at(code_copy.index(peg))
      end
    end

    @board.place_feedback(feedback)
  end

  private

  def get_code
    @@valid_guesses.sample(4)
  end

end