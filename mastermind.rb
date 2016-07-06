require_relative 'player.rb'
require_relative 'board.rb'
class Game

  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to Mastermind!!"
    puts "Here are your color options:"
    puts "B = Blue"
    puts "O = Orange"
    puts "G = Green"
    puts "R = Red"
    puts "P = Purple"
    puts "Y = Yellow"
    assign_players
    @codemaker.set_master_code
    @board.master_code = @codemaker.master_code
    12.times do
      turn
      break if win?
    end
    final_message
  end

  def turn
    @board.render
    @codebreaker.guess_code
    @board.code = @codebreaker.code
    @board.enter_guess
    @board.add_keys
  end

  def assign_players
    until @codemaker
      puts "Would you like to play as Codemaker(m) or Codebreaker(b)? "
      choice = gets.chomp
      if choice == "m"
        @codemaker = Human.new
        @codebreaker = Computer.new
      elsif choice == "b"
        @codemaker = Computer.new
        @codebreaker = Human.new
      end
    end
  end

  def win?
    @codemaker.master_code == @codebreaker.code
  end

  def final_message
    if win?
      puts "You win!!"
    else
      puts "You lose!!"
    end
  end
end
