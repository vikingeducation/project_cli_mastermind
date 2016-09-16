require './board.rb'
require './player.rb'

# The Mastermind class is responsible for running and playing the Mastermind
# game
class Mastermind
  def initialize
    @board = Board.new
  end

  def play
    player
    @board.make_code(@code_maker.code)
    loop do
      @board.render
      @board.guess(@code_breaker.guess)
      break if check_game_over?
    end
  end

  private

  def player
    puts 'Would you like to be the Code Breaker, or the Code Maker?'
    puts 'Put "B" for Breaker or "M" for Maker...'
    choice = gets.chomp
    if choice == 'B'
      @code_maker = Computer.new
      @code_breaker = Human.new
    else
      @code_maker = Human.new
      @code_breaker = Computer.new
    end
  end

  def check_game_over?
    check_code_broken? || check_no_guesses?
  end

  def check_code_broken?
    return false unless @board.check_victory?
    puts 'Code Breaker wins! Congratulations!'
    true
  end

  def check_no_guesses?
    return false unless @board.no_attempts?
    puts "Code Maker wins with the code #{@board.code}!"
    true
  end
end
