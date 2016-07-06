class Board

  

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
  end

  def feedback
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
    if /\Acodemaker\z/i.match role
      @maker = Codemaker.new(name)
      @breaker = Codebreaker.new(:computer)
    elsif /\Acodebreaker\z/i.match role
      @breaker = Codebreaker.new(name)
      @maker = Codemaker.new(:computer)
    end
  end

  def render

  end

  def play
    loop do
      guess = @breaker.get_guess
      @maker.feedback(guess)
      end?
    end
  end

  def end?

  end

end


class Peg

  def color

  end

end


class CodePeg < Peg
  CODE_COLORS = {:r => "red", :b => "blue", :y => "yellow", :g => "green", :o => "orange", :v => "violet"}



end

class KeyPeg < Peg

end