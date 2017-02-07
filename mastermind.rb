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
      break if game_over?
    end
  end

  # check if game is over
  def check_game_over
    # check for codebreaker victory
    # check for codebreaker loss
    check_codebreaker_victory || check_codebreaker_loss
  end

  # check_codebreaker_victory
  def check_codebreaker_victory
    # IF board says last guess is a winning_combination?
    if @board.winning_combination?
      # display a message for codebreaker solving code
      puts "Congratulations #{codebreaker.name}, you solved the code!"
      true
    else
      false
    end
  end

  # check_codebreaker_loss
    # IF board says the board is full?
      # display a message for codebreaker not solving code
end