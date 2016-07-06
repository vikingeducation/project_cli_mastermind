class Peg

  attr_reader :color

end


class CodePeg < Peg
  
  COLORS = { :r => "red", :b => "blue", :y => "yellow", :g => "green", :o => "orange", :v => "violet"}

  def initialize(color)
    @color = COLORS[color]
  end

end

class KeyPeg < Peg

  COLORS = { :b => "black", :w => "white" }

  def initialize(color)
    @color = COLORS[color]
  end

end

class Board

  attr_reader :pattern

  def initialize(pattern)
    pegs = pattern.map do |c|
      CodePeg.new(c.to_sym)
    end
    @pattern = pegs
  end

end

class Player
  def initialize(role)
    case role
    when String
      @mode = :human
    when Symbol
      @mode = role
    end
  end
end

class Codemaker < Player

  def make_pattern
    case @mode
    when :human
      pattern = gets.chomp.gsub(" ","").split(",")
      @pattern = Board.new(pattern)
    when :computer
    end
  end

  def feedback(guess)
    guess.each do |g|

    end
  end

  def check_guess(guess)
  end

end


class Codebreaker < Player

  def get_guess
    case @mode
    when :human
      guess = gets.chomp.gsub(" ", "").split(",")
    when :computer
    end
  end

end

class Game

  def initialize
    welcome
    play

  end

  def welcome
    "Welcome to Mastermind"
    "What is your name"
    name = gets.chomp
    "Do you want to be the Codemaker or Codebreaker?"
    get_role(name)
  end

  def get_role(name)
    role = gets.chomp
    case role.downcase
    when 'codemaker'
      @maker = Codemaker.new(name)
      @breaker = Codebreaker.new(:computer)
    when 'codebreaker'
      @breaker = Codebreaker.new(name)
      @maker = Codemaker.new(:computer)
    end
  end

  def render

  end

  def play
    @maker.make_pattern
    loop do
      guess = @breaker.get_guess
      @maker.feedback(guess)
      end?
    end
  end

  def end?

  end

end


def test
  board = Board.new(['r','b','r'])
end

test