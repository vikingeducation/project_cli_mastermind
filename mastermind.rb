# human as codebreaker
# render the board
# prompt guess
# feedback (color, position)
# loop
# 12 turns

# 4 peg slots
# 2 colors: black, white

# prompt choose
# 1. if codemaker:
# 1.1 prompt code
# 1.2 ai play

# elsif codebreaker run as usual

require "set"

class Player
  attr_accessor :type, :pegs

  def initialize(type)
    @type = type
    @pegs = Set.new [:black, :white, :yellow]
  end

  def guess
    if type == :human
      gets
    else
      (0...4).map { pegs.to_a.sample.to_s }.join(", ")
    end
  end

end

class Mastermind

  attr_accessor :guess, :guesses, :pegs, :code, :board, :player

  def initialize
    # populate the board
    @guess = nil
    @guesses = 0
    @pegs = Set.new [:black, :white, :yellow]
    @code = nil
    @board = []
    @player = nil
  end

  def instructions
    info = [
      "\nEnter your guess for each peg separated by a comma.",
      "Valid colors are: #{pegs.to_a.join(", ")}",
      "i.e: black, white, yellow, black.",
      "You have 12 guesses"
    ]
    info.each { |msg| puts msg }
  end

  def play_mode
    puts "\nDo you want to play as the codemaker [1] or codebreaker [2]?"
    print "[1/2] > "
    mode = gets.strip.to_i
    if mode == 1
      puts "Insert the code:"
      self.code = validate_code(gets)
      self.player = Player.new(:ai)
    else
      self.code = (0...4).map { pegs.to_a.sample }
      self.player = Player.new(:human)
    end
  end

  # ----------------------
  # Board
  # ----------------------

  def render
    board.each.with_index do |row, i|
      puts "#{i+1}: #{row.to_s}"
    end
  end

  # ----------------------
  # Validation
  # ----------------------

  def validate_code(code_)
    code_.split(",").map { |g| g.strip.to_sym }
  end

  def valid_guess?
    self.guess.all? do |g|
      pegs.include?(g)
    end
  end

  # ----------------------
  # End game
  # ----------------------

  def win?
    board[-1] == code
  end

  def win
    puts "\nYou win!"
  end

  def lose
    puts "\nYou're out of guesses.\nGame over."
    puts "The correct answer was: " + code.to_s
  end

  # ----------------------
  # Guess
  # ----------------------

  def prompt_guess
    print "\nEnter guess > "
    self.player.guess
  end

  def wrong_guess?
    board[-1] != code
  end

  def wrong_guess
    puts "\nYour guess is wrong:"
    guess.each_with_index do |g, i|
      msg = "#{i+1}: "
      if g == self.code[i]
        msg += "correct"
      else
        msg += "wrong color"
      end
      puts msg
    end
  end

  def output_guesses_remaining
    puts "\nGuesses remaining: #{12 - guesses}"
  end

  # ----------------------
  # main
  # ----------------------


  def run_game
    render
    if guesses >= 12
      lose
    elsif win?
      win
    else
      output_guesses_remaining
      self.guess = validate_code(prompt_guess)
      if valid_guess?
        self.guesses += 1
        board << guess
        if wrong_guess?
          wrong_guess
        end
      else
        puts "\nEnter a valid guess"
      end
      run_game
    end
  end

  def play
    play_mode
    instructions
    run_game
  end

end

m = Mastermind.new
m.play
