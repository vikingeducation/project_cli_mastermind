class Codemaker
  include DataIO
  attr_reader :code

  def initialize(board)
    @board = board

    # TODO make code more private?
    @code = get_code
    puts @code.to_s # TODO: delete this
  end

  def get_feedback
    guess = @board.guesses.last.deep_dup
    code_copy = @code.deep_dup
    feedback = feedback_algorithm(code_copy, guess)

    @board.place_feedback(feedback)
  end

  private

  def get_code
    Array.new(4) { VALID_GUESSES.sample }
  end

end