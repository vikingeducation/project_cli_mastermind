# All actions related to a Player
class Player
  # Store the number of turns the player has had
  attr-accessor :turns
end

# Player when the user is the not the codemaker
class Computer

end

# Display the Board
class Board
  attr-accessor :board

# Show the board at the beginning of the game
  def initialize
  end

  def render
    # display the current state of the board
  end

# add_piece
  def add_piece(coords, piece)
      # IF piece_location_valid?
      if piece_location_valid?(coords)
          # place piece
          @board_arr[coords[0]][coords[1]] = piece
          true
      else
          false
      end
  end

  # piece_location_valid?
  def piece_location_valid?(coords)
      # Is the placement within_valid_coordinates?
      if within_valid_coordinates?(coords)
          # Are the piece coordinates_available?
          coordinates_available?(coords)
      end
  end


end

# Deals with the running of the game and the rules
class Game
  
  # COLORS = ["R", "G", "B", "Y", "O", "P"]


  def initialize
    # @codemaker = Player.new
    # @codebreaker = Player.
  end

  # Ask the user to enter a guess
  def play
    # Display game instructions
    # Get user guess
    # Ask the user whether they want to be the codemaker or codebreaker
    # Check if the game should continue under 12
    reveal_code
  end

  def reveal_code
  end

  def check_input?
    # Check if the player has entered a guess in the correct format
  end
  
  Has the player fit the criteria to make a guess
  def valid_guess?
    # Is the user turns still under the maximum number of turns
  end

  # Check if the player has won the game
  def game_won?
    # Is the latest move match the code maker pattern
  end
end