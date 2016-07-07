COLORS = ["r", "b", "g", "p", "y", "o"]

class Game
  def initialize
    @board = Board.new()
    @player = Player.new()
    @code = Code.new
  end


  def display_available_colors
    puts "The following colors are available:"
    COLORS.each do |color|
      print color + " "
    end
    3.times {puts}
  end

  def play
    until over?
      @board.display_board 
      puts @code.answer   
      display_available_colors 
      guess = @player.get_guess
      exit if win?(guess)
      add_guess_to_board(guess)
      @board.display_board
    end
    puts "The codemaster won! This was the answer: #{@code.answer}"
  end

  def add_guess_to_board(guess)
      guess_with_pegs = guess.concat(black_and_white_result(guess))
      @board.rows[@player.guesses] = guess_with_pegs
      @player.guesses += 1
  end

  def black_and_white_result(guess)
    black = check_for_black(guess, @code.answer)
    white = check_for_white(guess, @code.answer) - black
    [black, white]
  end

  def over?
    @player.guesses == 12
  end

  def win?(guess)
    if guess == @code.answer 
      puts "You cracked the code! Congrats!" 
      true
    end
  end

  def check_for_black(guess,answer)
    black = 0
    guess.each_with_index do |color, index|
      if answer[index] == color
        black += 1
      end
    end
    black
  end

  def check_for_white(guess, answer)
    white = 0
    new_answer = answer.dup
    guess.each_with_index do |color|
      if new_answer.include?(color)
        white += 1
        new_answer.delete_at(new_answer.index(color))
      end
    end
    white
  end

end


class Board
  attr_accessor :rows

  def initialize
    @rows = 12.times.map {[]}
  end

  def display_board
    # system 'clear'
    @rows.each_with_index do |row, index|
      print "#{index+1} \t#{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      print "\tblack=#{row[4]}" unless row[4].nil?
      print "\twhite=#{row[5]}" unless row[5].nil?
      puts
    end
    puts "\tx x x x"
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
  attr_reader :answer
  def initialize(answer = Code.generate)
    @answer = answer
  end

  def self.generate
    4.times.map {COLORS.sample}
  end
end

g = Game.new
g.play
