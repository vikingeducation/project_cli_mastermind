=begin
 game = Board.new class 
   render method - to print board  X
   track the board pieces X
   set answer X
   check victory X
   check full

 Player class
    place pins 

  human class < player class
      input from human X
  computer class < player class
      input from ai

  Maker
    sets the solution pieces randomly
  Mastermind class
     tell the board to render X
     tell the player to place pieces X
     tells the board to check victory X
       unless victory && !full next X
         victor message X



         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]
         [ X X X X ]

      


=end

require 'colorize'


class Board
  attr_reader :board # :pieces
  def initialize

    # "X" is a blank space


    @board = Array.new(12) { Array.new(4) {"X"} }

    @pieces = ["R", "G", "B", "T", "O", "M", "K", "E"]

    set_solution

   

  end

  def render

    puts

    12.times do |i|
      p @board[i]
    end
    puts
    puts "Pieces:".black
    8.times do |i|
      print (@pieces[i] + "\s")
    end
    puts "\n\n"

  end

  def place_pin(input)
  
      
     board[0] = input
     board.rotate!

  end


  def set_solution

    # @solution = ["R", "G", "B", "T", "O", "M", "K", "E"].sample(4)

    # @solution = @pieces.sample(4)

    @solution = ["R", "G", "B", "T"]


  end

  def victory?
    board[11] == @solution
  end



end



class Player

  def place_pin



  end

end

class Human < Player

  def initialize(board)
      @board = board
  end

  def place_pin (board)
  
  end

  def take_turn

    input = ""

    loop do
      puts "Enter a piece."
      input = gets.chomp.upcase
      break
    end  
   @board.place_pin(input.chars)
  end

end

class Computer < Player

end


class Mastermind


  
  def play
    game = Board.new
    human = Human.new(game)
   
    12.times do
      game.render
      human.take_turn
      if game.victory?
        puts "You Won!"
        break
      end
    end

    

    unless game.victory?
      puts "You no win"
      print "The solution was \t"
      4.times do |i|
        print (@game.solution[i] + "\s")
      end
    end
  end

end


m = Mastermind.new

m.play

