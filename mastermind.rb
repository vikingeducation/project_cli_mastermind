require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computer_player.rb'

# Controls the game play
class Mastermind
  #initialize
  def initialize
    # set up the board
    @board = Board.new

    # set up the players
    @human_player = Player.new("Player One", @board)
    @computer_player = ComputerPlayer.new("Player Two", @board)
  end

  # play
  def play
    # ask user to choose between codebreaker or codemaker
    pick_roles

    # ask for codemaker to set code
    @codemaker.get_code

    # loop infinitely
    loop do
      # call the board rendering method
      @board.render

      # ask for codebreaker to make guess
      @codebreaker.get_guess

      # break the loop if the game is over
      break if check_game_over
    end
  end

  def pick_roles
    human_role = @human_player.get_role_choice

    if human_role == "codebreaker"
      @codebreaker = @human_player
      @codemaker = @computer_player
    elsif human_role == "codemaker"
      @codemaker = @human_player
      @codebreaker = @computer_player
    else
      puts "Invalid role choice."
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
      winner_message(@codebreaker)
      true
    else
      false
    end
  end

  # check_codebreaker_loss
  def check_codebreaker_loss
    # IF board says the board is full?
    if @board.full?
      # display a message for codebreaker not solving code
      @board.render
      winner_message(@codemaker)
      true
    end
  end

  def winner_message(winner)
    if winner.class == ComputerPlayer
      puts "Looks like the computer won this round..."
    else
      puts "Congratulations, you won!"
    end

    if @codemaker.class == ComputerPlayer
      puts "The secret code was #{@board.secret_code}"
    end
  end
end

game = Mastermind.new
game.play