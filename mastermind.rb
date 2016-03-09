
require_relative "player"
require_relative "board"

class Mastermind
  attr_reader :turn
  def initialize
    @board = Board.new
    @player = Player.new
    @turn = 1
  end

  def play
    instruction
    type = choose_game_type
    start_game type
  end


  def choose_game_type
    loop do
      puts "do you want to be the CodeBreaker ( -B- ) or the CodeMaker ( -M- ) ?"
      input = gets.chomp.upcase
      if input == "B"
        return "B"
      elsif input == "M"
        return "M"
      end
    end
  end

  def start_game type
    if type == "B"
      code_breaker
    else
      code_maker
    end
  end

  def code_breaker
    @board.create_code
    @board.render_board
    while turn < 13
      guess = @player.get_combination

      @board.save_guess( guess, turn )
      @board.compare( guess, turn )

      @board.render_board
      @turn += 1
    end
  end

  def code_maker
    @board.render_board
    code = @player.get_combination
    @board.save_code code
    while turn < 13
      computer_guess = @board.make_guess
      @board.save_guess( computer_guess, turn )
      @board.compare( computer_guess, turn )   

      @board.render_board
      @turn += 1
    end
  end

  def instruction
    puts "hello"
    puts "guess the combination\n"
    puts "Enter Your Combination, compose of 4 numbers\n"
    puts "In between 1 and 6, like so :   2 4 1 6\n"
  end
end


game = Mastermind.new
game.play





