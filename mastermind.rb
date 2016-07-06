require 'pry'

class Peg

  attr_reader :color

end


class CodePeg < Peg
  
  COLORS = { :r => "r", :b => "b", :y => "y", :g => "g", :o => "o", :v => "v"}

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
        puts "Type in your pattern."
        pattern = gets.chomp.gsub(" ","").split(",")
        @pattern = Board.new(pattern).pattern
      when :computer
    end
  end

  def feedback(guess)
    key_pegs = []
    guess.each_index do |i|
      key_pegs << check_guess(i, guess)
    end
    puts key_pegs
    key_pegs
  end

  def check_guess(i, guess)
    if @pattern[i].color == guess[i]
      return KeyPeg.new(:w)
    else 
      return KeyPeg.new(:b)
    end
  end

end


class Codebreaker < Player

  def get_guess
    case @mode
    when :human
      guess = gets.chomp.gsub(" ", "").split(",")
    when :computer
      guess = []
      4.times do 
        guess << CodePeg::COLORS.values.sample
      end
      guess
    end
  end

end

class Game

  def initialize
    welcome
    play
  end

  def welcome
    puts "Welcome to Mastermind"
    puts "What is your name"
    name = gets.chomp
    puts "Do you want to be the Codemaker or Codebreaker?"
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
    output = []
    @board.each do |peg|
      output << peg.color
    end
    p output
  end

  def play
    binding.pry
    @board = @maker.make_pattern
    puts @board
    render
    guess = @breaker.get_guess
    p guess
    feedback = @maker.feedback(guess)
    p feedback
    abort
    # loop do
    #   render
    #   guess = @breaker.get_guess
    #   feedback = @maker.feedback(guess)
    #   end?(feedback)
    # end
  end

  def end?(feedback)
    if feedback.all? { |f| f.color == "w" }
      puts "Codebreaker wins!"
      abort
    end
  end

end


def test
  Game.new
end

test