require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'board'

class Game
  attr_accessor :codemaker, :codebreaker, :board, :code, :guess
  
  def initialize
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @board = Board.new
    @code = @codemaker.code
  end

  def determine_codemaker
    puts "Enter 1 if you'd like to be the code maker and 2 
      if you'd like the computer to be the code maker:"
    @who_is_codemaker = gets.chomp
  end

  def assign_guess
    @guess = codebreaker.make_guess
  end

  def guess_sequence
    board.prompt_for_guess
    assign_guess
    board.add_guess(guess)
    board.increment_guess_number
  end

  def update_board
    board.create_hint(guess, code)
    board.display_board
  end

  def play
    while guess != code && board.guess_number <= 12
      guess_sequence
      update_board
    end
    guess == code ? (puts 'Good Job! You win!') : (puts 'Sorry, no more guesses!')
  end
end
