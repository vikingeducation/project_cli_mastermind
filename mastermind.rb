# Mastermind:
# Codemaker generates secret code (4 ordered unique colored pegs)
# Codebreaker places pegs on the board
# Codemaker generates response and populates the corresponding row on the board
# prev 2 steps loop for max 12 times
# exit early of codebreaker guesses the secret
#
# 1. Player > CodeMaker, CodeBreaker
# 2. Board       - Array of Rows
# 3. Rows        - :pegs[4], :close , :exact
# 3. Peg         - @color

#Verbs :
# 1. place pegs on board - guess
# 2. Compare code with secret
# 3. Print number of close and exact pegs after each guess
require 'pry'

class Peg
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def ==(other_peg)
    self.color == other_peg.color
  end

  def to_s
    puts "#{self.color}"
  end

  def eql?(other_peg)
    self.color == other_peg.color
  end

  def hash
    @color.hash
  end

end

class Row
  attr_accessor :pegs, :response
  def initialize(num_cols)
    @pegs = []
    num_cols.times { @pegs << nil }
    @response = { close: 0, exact: 0}
  end
end

class Player
  def initialize(name)
    @name = name
  end
end

class CodeBreaker < Player
  def initialize
    super "code_breaker"
  end

  def place_pegs(board, index)
    row = board.slots[index]
    row.pegs[0] = Peg.new(:r)
    row.pegs[1] = Peg.new(:y)
    row.pegs[2] = Peg.new(:g)
    row.pegs[3] = Peg.new(:b)
  end
end

class CodeMaker < Player
  def initialize
    super "code_maker"
    @secret = []
  end

  def generate_secret
    @secret << Peg.new(:r)
    @secret << Peg.new(:g)
    @secret << Peg.new(:y)
    @secret << Peg.new(:o)
  end

  def generate_response(board, index)
    row = board.slots[index]
    response = row.response
    pegs = row.pegs
    response[:exact]  = @secret.each_index.select { |i| @secret[i] == pegs[i] }.count
    response[:close] = (pegs & @secret).count - response[:exact]
  end
end

class Board
  COLORS = %w(Red Green Blue Yellow Orange Purple)
  WINNING_PEGS = %w(r g y o)
  attr_accessor :slots
  def initialize(num_rows, num_cols)
    @slots = []
    num_rows.times { @slots << Row.new(num_cols) }
  end

  def render
    system "clear"
    @slots.each_with_index do |row, index|
      puts "#{row.pegs} \t#{row.response}"
      # print "#{row.pegs[0]} #{row.pegs[1]} #{row.pegs[2]} #{row.pegs[3]} \t#{row.response}"
    end
  end
end

class Mastermind
  NUM_SECRET_PEGS = 4
  TOTAL_PEGS      = 6
  attr_reader :max_guess
  def initialize(max_guess)
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
    @secret = []
    @max_guess = max_guess
    @board = Board.new(max_guess, NUM_SECRET_PEGS)
  end

  def play
    welcome_msg
    @secret = @code_maker.generate_secret
    @board.render
    puts
    (0..@max_guess-1).each do |index|
      @code_breaker.place_pegs(@board, index)
      @code_maker.generate_response(@board, index)
      @board.render
      break
    end
  end

  private

  def welcome_msg
    greet_string = <<-GREETING
    # Welcome to Mastermind!
    Available pegs : Red(r) Green(g) Blue(b) Yellow(y) Orange(o) Purple(p)
    Enter input in following format to place the 4 pegs on the board in desired order
    [rgby]
    ############
    GREETING
    puts greet_string
  end

  def get_input_from_player
    input = []
    loop do
      puts "Enter Peg order>"
      raw_input = gets.chomp
      if raw_input == 'q'
        exit
      else
        input = raw_input.split("")
        if input & ['r', 'g', 'b', 'g', 'y', 'o'] == input &&
           input.size == 4
          break
        end
        puts "Please enter a valid input - 4 unique pegs"
      end
    end
    input
  end
end




game = Mastermind.new(2)
game.play
