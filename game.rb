require 'pry'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'board'

class Game
  attr_accessor :codemaker, :codebreaker, :board, :code, :guess
  
  def initialize
    #@codemaker = CodeMaker.new
    #@codebreaker = CodeBreaker.new
    @board = Board.new
    #@code = @codemaker.code
  end

  def determine_codemaker
    puts "Enter 1 if you'd like the computer to be the code maker 
      and any other character if you'd like to be the code maker:"
    #@who_is_codemaker = gets.chomp.to_i
    if gets.chomp.to_i == 1
      @codemaker = ComputerPlayer.new
      @codebreaker = HumanPlayer.new
    else
      @codemaker = HumanPlayer.new
      @codebreaker = ComputerPlayer.new
    end
  end

  def create_code
    codemaker.create_code
  end

  def assign_guess
    self.guess = codebreaker.make_guess
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
    #codemaker.create_code(determine_codemaker) 
    determine_codemaker
    @code = create_code
    while guess != code && board.guess_number <= 12
      guess_sequence
      update_board
    end
    #guess == code ? (puts 'Good Job! You win!') : (puts 'Sorry, no more guesses!')
  end
end
