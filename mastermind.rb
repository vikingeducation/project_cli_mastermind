COLORS = ["r", "b", "g", "p", "y", "o"]

class Game
  def initialize
    @board = Board.new()
    @player = Player.new()
    @code = Code.new
  end

  def play
    until over?
      @board.display_board
      @player.get_guess



      @player.guesses = 12
    end


  end

  def over?
    @player.guesses == 12 
  end
end


class Board
  def initialize
    @board = 12.times.map {[]}
  end

  def display_board
    @board.each_with_index do |row, index|
      print "#{index+1} #{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      puts
    end
    puts "   x x x x"
  end
end


class Player
  attr_accessor :guesses
  def initialize
    @guesses = 0
  end

  def get_guess
    loop do
      puts "what is your guess?"
      guess =  gets.chomp.downcase.gsub(/\s+/, "").split(',')
      break if valid?(guess)
      puts "That's not a valid guess. Enter 4 colors separated by commas, e.g. r, g, b, y"
    end
  end

  def valid?(guess)
    guess.size == 4 && 
    guess.all? {|item| COLORS.include?(item)}
  end
end


class Code
  
  def initialize(answer = Code.generate)
    @answer = answer
  end

  def self.generate
    4.times.map {COLORS.sample} 
  end
end

g = Game.new
g.play