require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'board'

class Mastermind
  def initialize()
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @turns_left = 12
    @winning_sequence = @board.winning_sequence
  end

  def play
    instructions
    loop do
      take_turn unless game_over?
    end
  end

  def take_turn
    guess = @codebreaker.make_guess
    win?
    number_of_exact_answers = @board.exact_answers
    number_of_right_colors = @board.exact_colors
    @board.add_row(guess)#(guess, number_of_exact_answers, number_of_right_colors)
    @board.render
    @turns_left -= 1
  end

  def instructions
    #
  end

  def game_over?
    gameover if @turns_left < 1
  end

  def gameover
    puts "Game over."
    exit
  end

  def win?
    win if guess == @winning_sequence
  end

  def win
    puts "You win!"
    exit
  end

  def lose?
    #
  end
end

Mastermind.new.play


#Mastermind
  #play
  #gameover?
  #win?
  #lose?
