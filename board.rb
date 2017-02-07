# Maintains game board state
class Board
  # initialize board
  def initialize
    # set up blank data structure
    @board = Array.new(12) { Array.new(4) }
  end

  # render
  def render
    puts
    # loop through data structure
    @board.each do |row|
      # display an existing peg if any, else blank
      row.each do |slot|
        slot.nil? ? print "-" : print slot
      end
      puts
    end
    puts
  end

  # set_code
  def set_code(code)
    # IF valid_code?
    if valid_code?(code)
      # set code
      @secret_code = code
    # ELSE
      puts "Your code doesn't follow the rules!"
    end
  end

  # secret_code
    # If secret_code has been set, return the secret_code

  # add_guess
    # IF valid_code?
      # place guess
    # ELSE
      # display error message

  # valid_code?
    # is each peg in the code a valid_color?

  # valid_color?
    # is the peg included in the list of valid_colors?

  # close_pegs
    # number of pegs in the guess with correct color, but incorrect location

  # exact_pegs
    # number of pegs in the guess with correct color, and correct location

  # winning_combination?
    # does the last guess have 4 exact_pegs?

  # full?
    # does every row contain a guess?
end