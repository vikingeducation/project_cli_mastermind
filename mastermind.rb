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
    puts "You have #{@turns_left} turns left"
    guess = @codebreaker.make_guess
    win?(guess)
    @board.add_row(guess)
    @board.render
    @turns_left -= 1
  end

  def instructions
    puts "See Wikipedia: https://en.wikipedia.org/wiki/Mastermind_(board_game)"
  end

  def game_over?
    gameover if @turns_left < 1
  end

  def gameover
    puts "Game over."
    exit
  end

  def win?(guess)
    win if guess == @winning_sequence
  end

  def win
    puts "You win!"
    exit
  end

end

Mastermind.new.play
