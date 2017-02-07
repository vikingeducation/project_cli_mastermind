require_relative 'board.rb'

# Controls the game play
class Mastermind
  #initialize
  def initialize
    # set up the board
    @board = Board.new

    # set up the players
    @player_one = Player.new("Player One", @board)
    @player_two = Player.new("Player Two", @board)

    # assign the starting player
    @current_player = @player_one
  end

  # play
    # ask for starting player to set code
    # switch players
    # loop infinitely
      # call the board rendering method
      # ask for player to make guess
      # break the loop if the game is over

  # check_game_over
    # check_victory
    # check_loss

  # check_victory
    # IF board says guess is a winning_combination?
      # display a victory message

  # check_loss
    # IF board says the board is full?
      # display a loss message
end