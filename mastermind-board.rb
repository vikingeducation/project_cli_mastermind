require 'pry'

class Board

  def initialize
    feedback_pegs = ["W", "B'"]
    @rows = Array.new(12) { Array.new(4, nil) }
    @feedback = Array.new(12) { Array.new(4, nil) }
  end

  def render
    #display board
  end

  def process(guess)
    register_guess(guess)
    gets_feedback(guess)
  end


  def register_guess(guess)
    @rows << guess
  end

  def code
    @code
  end

  def gets_feedback(guess)
    guess.each do |item|
      @code.include?(item)
  end

Each white peg means that one of the guessed pegs is correct, but is in the wrong hole.

Each red (or black) peg means that one of the guessed pegs is correct, and is in the right hole.
The order of the white and black pegs does not matter.

end