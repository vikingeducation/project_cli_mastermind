require 'colorize'
require 'pry'
require './sub_classes.rb'

class MasterMind
  def initialize
    @secret_code = SecretCode.new
    @board = Board.new
    @player = CodeBreaker.new
  end

  def main_loop
    loop do
    @board.render_board
    @guess = @player.get_guess
    player_quit?
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
go.main_loop
