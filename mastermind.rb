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

  COLORS = { :b => "b", :w => "w" }

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
        pattern = []
        4.times do
          pattern.push CodePeg::COLORS.values.sample
        end
        @pattern = Board.new(pattern).pattern
    end
  end

  def feedback(guess)
    key_pegs = []
    guess.each_index do |i|
      key_pegs << check_guess(i, guess)
    end
    key_pegs.map { |peg| peg.color }
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
    @counter = 0
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

  ### FOR TESTING PURPOSES ONLY ###
  # def render
  #   output = []
  #   @board.each do |peg|
  #     output << peg.color
  #   end
  #   puts "Render: #{output}"
  # end

  def play
    @board = @maker.make_pattern
    until game_over? || win?
      @guess = @breaker.get_guess
      puts "Breaker's guess:\n#{@guess}"
      @feedback = @maker.feedback(@guess)
      puts "Maker's feedback:\n#{@feedback}"
      @counter += 1
    end
    
  end

  def game_over?
    if @counter == 12
      puts "You are out of turns"
      abort
    end
  end

  def win?
    if @feedback
      if @feedback.all? { |f| f == "w" }
        puts "Codebreaker wins!"
        abort
      end
    end
  end

end


def test
  Game.new
end

test