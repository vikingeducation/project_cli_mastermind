class Board
  attr_accessor :guess_number
  def initialize
    @board = []
    @guess_number = 0
  end

  def increment_guess_number
    @guess_number += 1
  end

  def display_board
    @board.each { |row| p row }
  end

  def prompt_for_guess
    if @guess_number == 0
      puts "Enter your first guess. If it matches the code maker's code, 
            you win! Otherwise, the code maker will give you clues to help
            you along."
    else
      puts "Nope! Try again!"
    end
  end

  def add_guess(guess)
    @board << guess
  end
end

class CodeMaker
  attr_reader :code 

  def initialize
    @pegs = %w(R G B Y O T)
    @code = []
    4.times { @code << @pegs.sample }
  end
  
end 

class CodeBreaker
  def make_guess
    @guess = gets.chomp.split('')
  end
end 

class Game 
  def initialize 
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @board = Board.new
  end

  def play
    while @guess != @codemaker.code
      p @codemaker.code
    @board.prompt_for_guess
    @guess = @codebreaker.make_guess
    @board.add_guess(@guess)
    @board.increment_guess_number
    @board.display_board
  end
  end
end

game = Game.new
game.play