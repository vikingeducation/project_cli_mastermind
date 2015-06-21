require 'colorize'
require 'pry'
require './sub_classes.rb'

class MasterMind
  def initialize
    @secret_code = SecretCode.new
    @board = Board.new
  end

  def maker_or_breaker
    mode = game_mode_input
    if mode == "2"
      @player = CodeBreaker.new
      @secret_code.code = @secret_code.create_secret_code
      main_loop(:human)
    elsif mode == "1"
      @player = AI.new
      @maker = CodeBreaker.new
      @secret_code.code = @maker.get_guess
      main_loop(:computer)
    else 
      exit 
    end
  end

  def game_mode_input
    input = ""
    loop do 
      system 'clear'
      puts "Welcome to Master Mind!"
      puts "Would you like to make or break the code?"
      print "Press 1 for maker, 2 for breaker > "
      input = gets.chomp
      print "\n"
      break if mode_input_valid?(input)
    end
    return input
  end

  def mode_input_valid?(input)
    if input == "1" || input == "2" || input == "q"
      return true
    end
  end

  def main_loop(playertype)
    loop do
      @board.render_board
      @guess = @player.get_guess
      player_quit? if @player.is_a?(CodeBreaker)
      @board.store_guess(@guess)
      feedback = @secret_code.feedback(@guess)
      @board.store_guess_feedback(feedback)
      game_end?
    end
  end

  def game_end?
    player_out_of_guesses? ||
    guess_correct?      
  end

  def player_quit?
    if @guess == [:q]
      @board.render_board(@secret_code.code)
      puts "Game Over!"
      exit
    end
  end

  def guess_correct?
    if @secret_code.correct_code?(@guess)
      @board.render_board(@secret_code.code)
      puts "You Win!"
      exit
    end
  end

  def player_out_of_guesses?
    if @player.guesses == 0
      @board.render_board(@secret_code.code)
      puts "No more guesses!"
      exit
    end
  end
  
  
end

go = MasterMind.new
#go.maker_or_breaker
