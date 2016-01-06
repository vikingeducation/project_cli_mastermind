
require 'board'
require 'rainbow'
require 'code'
require 'peg'


class Game
  TURN_LIMIT = 12
  def initialize
    @turn = 0
    @board = Board.new
    @solution = Code.random_code
    @guesses = []
  end


  def play
    ask_player_input
    puts "HELP"
    @board.generate_solution

    until game_over?
      ask_player_input

    end

  end

  private
  def ask_player_input
    loop do 
      puts "Enter your code. (e.g. 1 2 3 4)"
      input = gets.chomp
      array = input.scan(/\d/)
      unless array.length == 4
        puts "Invalid guess. Must enter 4 numbers."
        next
      end
      unless array.all?{ |i| i === (1..6)}
        puts "Invalid guess. Numbers must be between 1-6."
        next 
      end
      guess_code = Code.from_array(array)
      break
    end 
    @guesses << guess_code
  end 

  def game_over?
    out_of_turns? || guess_correct?
    false
  end

  def out_of_turns?
    @turn > TURN_LIMIT
  end

  def guess_correct?
    @guesses.any? { |guess| @solution == guess }
    false
  end

end


Game.new.play

