class Codemaker
  # TODO: Not DRY since also in codebreaker
  @@valid_guesses = ['r', 'b', 'g', 'y', 'p', 'o']

  def initialize(allow_dups, board)
    @board = board

    # TODO make code private?
    @code = @@valid_guesses.sample(4)
    puts @code.to_s # TODO: delete this
  end

  def get_feedback
    guess = @board.guesses.last
    feedback = Array.new(4, '')

    # Check correct color and position
    guess.each_with_index do |peg, index|
      if peg == @code[index]
        feedback[index] = '*'
      end
    end

    # Check what's left for correct color in wrong position
    feedback.each_with_index do |peg, index|

    end

    @board.place_feedback(feedback.sort)
  end

  private

end