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
      guess = @player.get_guess
      @board.rows[@player.guesses] = guess
      @board.display_board
      ####Should next three lines be a different method
      if win?(guess)
        puts "You cracked the code! Congrats!"
        exit
      end
      check_combination(guess, @code.answer)
      @player.guesses = 12
    end
  end

  def over?
    @player.guesses == 12 
  end

  def win?(guess)
    guess == @code.answer
  end

  def check_combination(guess, answer)
    black = 0
    white = 0
    new_answer = answer
    guess.each_with_index do |color, index|
      if answer[index] == color
        black += 1
      end
    guess.each_with_index do |color|
      if new_answer.include?(color)
        white += 1 
        new_answer.delete_at(new_answer.index(color))
      end
    end
    return [black, white - black]
  end
end


class Board
  attr_accessor :rows

  def initialize
    @rows = 12.times.map {[]}
  end

  def display_board
    @rows.each_with_index do |row, index|
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
    guess = ""
    loop do
      puts "what is your guess?"
      guess =  gets.chomp.downcase.gsub(/\s+/, "").split(',')
      break if valid?(guess)
      puts "That's not a valid guess. Enter 4 colors separated by commas, e.g. r, g, b, y"
    end
    guess
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