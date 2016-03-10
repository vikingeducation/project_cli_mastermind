
require_relative "player"
require_relative "board"
require_relative "computer"


class Mastermind
  attr_reader :turn

  def initialize
    @board = Board.new
    @player = Player.new
    @computer = Computer.new
    @code = {}
    @turn = 1
  end


  def play
    introduction
    type = choose_game_type
    start_game type
  end


  def choose_game_type
    loop do
      puts "\ndo you want to be the CodeBreaker ( -B- ) or the CodeMaker ( -M- ) ?\n"
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
    code = @computer.create_code
    @board.save code
    @board.render_board
    while turn < 13
      instruction
      guess = @player.get_combination

      @board.save( guess, turn )
      @board.compare( guess, turn )

      @board.render_board
      @turn += 1
    end
  end


  def code_maker
    @board.render_board
    instruction
    code = @player.get_combination
    @board.save code
    while turn < 13
      computer_guess = @computer.create_code
      @board.save( computer_guess, turn )
      @board.compare( computer_guess, turn )   

      @board.render_board
      @turn += 1
    end
  end


  def introduction
    puts "\n\n\n\n\n\n\nHi there ! This is Mastermind !"
    puts "This is a game where one player create The code combination\n"
    puts "And the other one try to break it !\n\n\n\n\n\n\n"
  end

  def instruction
    puts "Enter Your Combination, compose of 4 numbers\n"
    puts "In between 1 and 6, like so :   2 4 1 6\n"
  end
end


game = Mastermind.new
game.play





