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

  end

  def place_pin
  end

  def get_imput

    input = ""

    loop do
      puts "Enter a piece."
      input = gets.chomp.upcase
      if @board.pieces.include?(input)
        break
      end
    end      
  end

end

class Computer < Player

end


class Mastermind

  board = Board.new
  @human = Human.new(board)



end

