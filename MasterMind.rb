require 'colorize'
require 'pry'
require './sub_classes.rb'


class MasterMind
  def initialize
    @secret_code = SecretCode.new
    @board = Board.new
    @last_feedback = nil
  end

  def setup_game
    mode = game_mode_input
    case mode
      when "2"
        player_is_breaker
      when "1"
        player_is_maker
    end
  end

  private

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
    if input == "1" || input == "2"
      return true
    end
  end

  def player_is_breaker
    @breaker = Player.new
    @secret_code.code = @secret_code.create_secret_code
    main_loop
  end

  def player_is_maker
    @breaker = AI.new
    @maker = Player.new
    @secret_code.code = @maker.get_guess
    main_loop
  end

  def main_loop
    loop do
      @board.render_board
      @guess = @breaker.get_guess(@last_feedback)
      player_quit? if @breaker.is_a?(Player)
      @board.store_guess(@guess)
      feedback = @secret_code.feedback(@guess)
      @board.store_guess_feedback(feedback)
      @last_feedback = feedback
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
      puts "Code Broken in #{(13 - @breaker.guesses)} guesses!"
      puts "Code Breaker WINS!"
      exit
    end
  end

  def player_out_of_guesses?
    if @breaker.guesses == 0
      @board.render_board(@secret_code.code)
      puts "Code Breaker is out of guesses!"
      puts "Game Over!"
      exit
    end
  end
end


go = MasterMind.new
go.setup_game
