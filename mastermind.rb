
COLORS = ["green","red","blue","purple","orange","yellow"]
PEGS =["white","black"]

class Game

  def initialize

    @code = []
    @board = Board.new
    #define variables
    #randomly choosen code
  end

  def create_players

    @codemaker = Computer.new
    @codebreaker = Human.new

  end
    
  def play
    @code = @codemaker.generate

    #Game loop started (12 times)
    12.times do
      @board.add_to_board(@codemaker.guess)
      puts @board
    end

  end

    #render a board

    #player tries to guess
    #gives a feedback
    #player want to exit or wins?

    #After loop ends player loses
    #show the code

end

class Player


  

end

class Human < Player
  def initialize

  end

  def generate

  end

  def guess
    puts "Enter 4 colors from #{COLORS} (like this #{green red blue purple})"
    gets.chomp.split(" ")
  end

end

class Computer < Player

  def generate

    new_code = []

    4.times do 
      new_code << COLORS.sample
    end

    new_code
    
  end


  def guess
  end

end

class Board

  attr_reader :board

  def initialize

    @board=[]
    #[[4 colors, 4 pegs],[]...12]

  end

  def add_to_board (input)

    @board << input

  end

  def display_board

  end

end