require_relative 'board.rb'

# Controls the game play
class Mastermind
  #initialize
  def initialize
    # set up the board
    @board = Board.new

    # set up the players
    @codemaker = Player.new("Player One", @board)
    @codebreaker = Player.new("Player Two", @board)
  end

  # play
  def play
    # ask for codemaker to set code
    @codemaker.set_code

    # loop infinitely
    loop do
      # call the board rendering method
      @board.render

      # ask for codebreaker to make guess
      @codebreaker.guess_code

      # break the loop if the game is over
      break if check_game_over
    end
  end

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