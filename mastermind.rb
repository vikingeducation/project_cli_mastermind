class Mastermind
  def initialize
    #create board
    #create codemaker
    #create codebreaker
    #var # of game turns max
  end

  def play

    # render board
    #
    # codebreaker guesses
    #
    # if victory / lose conditions are met
    # => Display the victory / lose msg
    # => break loop
    # else
    # => Codemaker provides feedback (white/red signals)
  end

  def game_over?
    victory? || end_of_turns?
  end


end


class Player

  def initialize(board)
    @board = board
  end

  # private_class_method :new
    # factory method to create codemaker
    #
    #
    # factory method to create codebreaker
end

# Set up the game initially [Mastermind]
#   create board  [Board]
#   create players and roles [Player]
# Start the game loop [Mastermind]
#   Render the board  [Board]
#   Ask for and codebreakers guess [Player]
#   If the game should end  [Mastermind]
#     Display the proper victory / lose msg
#     stop looping
#   else
#     Codemaker gives feedback with white and red signals [Player]


