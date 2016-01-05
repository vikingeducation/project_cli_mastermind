require 'rainbow'

class Game
  def initialize
    @turn = 0
    @board = Board.new
  end

  def play
    @board.generate_solution
  end
end

class Board


  def initialize
    @solution = nil
  end

  def generate_solution
    Code.random_code
  end

  def random_peg
    PEGS.sample
  end
end

class Peg
  def initialize(display)
    @display = display
  end

  def display
    @display
  end

  def self.red
    new(Rainbow("1").red)
  end

  def self.orange
    new(Rainbow("2").cyan)
  end

  def self.yellow
    new(Rainbow("3").yellow)
  end

  def self.green
    new(Rainbow("4").green)
  end

  def self.blue
    new(Rainbow("5").blue)
  end

  def self.purple
    new(Rainbow("6").magenta)
  end
end

class Code

  PEGS = [Peg.red, Peg.orange, Peg.yellow, Peg.green, Peg.blue, Peg.purple]

  def initialize
    @pegs = []
  end

  def add_peg(peg)
    @pegs << peg
  end

  def self.random
    code = new
    code.add_peg(PEGS.sample) until code.full?
    code
  end

  def full?
    @pegs.length == 4
  end

  def display
    output = []
    @pegs.each do |peg|
      output << peg.display
    end
    output.join(' ')
  end
end

test = Code.random
puts test.display

