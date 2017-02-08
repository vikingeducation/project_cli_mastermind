require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computer_player.rb'

class Mastermind
  def initialize
    @board = Board.new
    @human_player = Player.new("Player One", @board)
    @computer_player = ComputerPlayer.new("Player Two", @board)
  end

  def play
    pick_roles
    @codemaker.get_code

    loop do
      @board.render
      @codebreaker.get_guess
      break if check_game_over
    end
  end

  private

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

  def check_game_over
    check_codebreaker_victory || check_codebreaker_loss
  end

  def check_codebreaker_victory
    if @board.winning_combination?
      winner_message(@codebreaker)
      true
    else
      false
    end
  end

  def check_codebreaker_loss
    if @board.full?
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