# Mastermind:
# Codemaker generates secret code (4 ordered unique colored pegs)
# Codebreaker places pegs on the board
# Codemaker generates response and populates the corresponding row on the board
# prev 2 steps loop for max 12 times
# exit early of codebreaker guesses the secret
#
# 1. Player > Human, Computer
# 2. Board       - Array of Rows
# 3. Rows        - pegs[4], :close , :exact
# 3. Peg         - color
# Verbs :
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
    color == other_peg.color
  end

  def to_s
    puts color.to_s
  end

  def eql?(other_peg)
    color == other_peg.color
  end

  def hash
    @color.hash
  end

  def color
    dict = { r: "Red", g: "Green", b: "Blue", y: "Yellow", o: "Orange", p: "Purple" }
    dict[@color]
  end
end

class Row
  attr_accessor :pegs, :response
  def initialize(num_cols)
    @pegs = []
    num_cols.times { @pegs << nil }
    @response = { close: 0, exact: 0 }
  end
end

class Player
  PEG_ARR = ['r', 'g', 'b', 'p', 'y', 'o'].freeze
  def initialize(name)
    @name = name
  end

  def validate_input(user_arr, available_arr)
    return false if user_arr.size != 4
    user_arr.each do |item|
      return false if !available_arr.include?(item)
    end
    true
  end

  def input_from_player
    input = []
    loop do
      puts "Enter Peg order>"
      raw_input = gets.chomp
      if raw_input == 'q'
        exit
      else
        input = raw_input.split("")
        break if validate_input(input, PEG_ARR)
        puts "Please enter a valid input - 4 pegs"
        puts "Available pegs : Red(r) Green(g) Blue(b) Yellow(y) Orange(o) Purple(p)"
      end
    end
    input
  end

  def generate_response(board, index)
    row = board.slots[index]
    response = row.response
    pegs = row.pegs
    response[:exact] = @secret.each_index.count { |i| @secret[i] == pegs[i] }
    response[:close] = @secret.each_index.count { |i| pegs.include?(@secret[i]) } - response[:exact]
  end
end

class Human < Player
  def initialize
    super "code_breaker"
    @secret = []
  end

  def place_pegs(board, index, _num_secret)
    row = board.slots[index]
    input_from_player.each_with_index do |str, i|
      row.pegs[i] = Peg.new(str.to_sym)
    end
  end

  def generate_secret(_num_secret)
    input_from_player.each do |str|
      @secret << Peg.new(str.to_sym)
    end
    @secret
  end
end

class Computer < Player
  def initialize
    super "code_maker"
    @secret = []
  end

  def generate_secret(num_secret)
    @secret = []
    PEG_ARR.shuffle[0..num_secret - 1].each do |str|
      @secret << Peg.new(str.to_sym)
    end
    @secret
  end

  def place_pegs(board, index, num_secret)
    row = board.slots[index]
    (0..num_secret - 1).each do |i|
      row.pegs[i] = Peg.new(PEG_ARR.sample.to_sym)
    end
  end
end

class Board
  attr_accessor :slots
  def initialize(num_rows, num_cols)
    @slots = []
    num_rows.times { @slots << Row.new(num_cols) }
  end

  def render(opts = { clear: true })
    system "clear" if opts[:clear]
    @slots.each_with_index do |row, index|
      print index.to_s.ljust(3) + "|\t"
      row.pegs.each { |peg| print peg ? peg.color + "\t\t" : "-\t\t" }
      puts "| [close: #{row.response[:close]} exact: #{row.response[:exact]}]"
    end
  end
end

class Mastermind
  NUM_SECRET_PEGS = 4
  TOTAL_PEGS      = 6
  attr_reader :max_guess
  def initialize(max_guess)
    @code_maker = nil
    @code_breaker = nil
    @secret = []
    @max_guess = max_guess
    @board = Board.new(max_guess, NUM_SECRET_PEGS)
  end

  def play
    welcome_msg
    select_role
    @secret = @code_maker.generate_secret(NUM_SECRET_PEGS)
    @board.render(clear: false)
    winner = nil
    puts
    (0..@max_guess - 1).each do |index|
      @code_breaker.place_pegs(@board, index, NUM_SECRET_PEGS)
      @code_maker.generate_response(@board, index)
      @board.render
      break if (winner = check_winner(@board, index))
    end
    gameover_msg(winner)
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

  def select_role
    puts "Do you want to be a code breaker (cb) or code maker (cm), please enter the corresponding string >"
    loop do
      input = gets.chomp
      if "cb" == input
        @code_breaker = Human.new
        @code_maker = Computer.new
        break
      elsif "cm" == input
        @code_maker = Human.new
        @code_breaker = Computer.new
        break
      else
        puts "Please enter a valid string 'cm' or 'cb' >"
      end
    end
  end

  def gameover_msg(winner)
    if winner
      if @code_breaker.is_a?(Human)
        puts "Congratulations! You win"
      else
        puts "Computer Wins! Your code is broken"
      end
    elsif @code_breaker.is_a?(Human)
      puts "Sorry! You ran out of guesses"
    else
      puts "You win! Computer failed to break you awesome code"
      print "Secret Code is [\t"
      @secret.each { |peg| print peg ? peg.color + "\t\t" : "-\t\t" }
      print " ]\n"
    end
  end

  def check_winner(board, index)
    row = board.slots[index]
    response = row.response
    response[:exact] == NUM_SECRET_PEGS
  end
end

game = Mastermind.new(12)
game.play
