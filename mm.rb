=begin
 Board class 
   render method - to print board  X
   track the board pieces X
   check victory
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
     tell the board to render
     tell the player to place pieces
     tells the board to check victory
       unless victory && !full next
         victor message



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


class Board
  attr_reader :board, :pieces

  def initialize

    # "X" is a blank space
    @board = [
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"]
             ]

    @pieces = %w[R G B T A M K E]

    

  end

  def render

    puts

    12.times do |i|
      p @board[i]
    end
    puts
    puts "Pieces:"
    p @pieces
    puts



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
     input = get_input
      puts board
      puts board[0]
      
     board[0] = input
     board.rotate!
  end

  def get_input

    input = ""

    loop do
      puts "Enter a piece."
      input = gets.chomp.upcase
      break
    end  
   input.chars
  end

end

class Computer < Player

end


class Mastermind
  
  def play
    board = Board.new
    human = Human.new(board)
   
    board.render
    human.place_pin(board)

    board.render
 end

end

