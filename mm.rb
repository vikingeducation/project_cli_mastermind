=begin
 game = Board.new class 
   render method - to print board  X
   track the board pieces X
   set answer X
   check victory X
   check full X

 Player class
    place pins X

  human class < player class
      input from human X
  computer class < player class
      input from ai

  Maker
    sets the solution pieces randomly X
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
  attr_reader :board, :solution, :pieces


  def initialize

    # "X" is a blank space

    @clues = Array.new(12) { Array.new(4) {"-"} }

    @board = Array.new(12) { Array.new(4) {"X"} }

    @pieces = ["R", "G", "B", "T", "O", "M", "K", "E"]

    set_solution

   

  end

  def render

    puts
      

    12.times do |i|
      
      @board[i].each do |x|
        board[0] = color_scheme[x] 
      end

      print "#{@board[i]} #{@clues[i]}"
      puts
    end
    puts
    puts "Pieces:".blue
    8.times do |i|
      print (@pieces[i] + "\s")
    end
    puts "\n\n"

  end
  
  def color_scheme
                 {"R" => "R".red,
                   "G" => "G".green,
                   "B" => "B".blue,
                   "T" => "T".cyan, 
                   "O" => "O".light_red,
                   "M" => "M".magenta,
                   "K" => "K".yellow,
                   "E" => "E".light_black }

            
  end


  def place_pin(input)
  
      
     @board[0] = input
     @clues[0] = new_clue

     @board.rotate!
     @clues.rotate!


  end

  #keeps track of clues

  def new_clue
  
  asterisks = 0
  bangs = 0
  new_clue = []

    4.times do |i|
      if @solution[i] == @board[0][i]
        asterisks += 1
      elsif @solution.include?(@board[0][i])
        bangs += 1
      end
    end

    asterisks.times {new_clue << "*" }
    bangs.times {new_clue << "!" }
    (4 - asterisks - bangs).times { new_clue << "-" }

    new_clue

  end



  def set_solution

    # @solution = ["R", "G", "B", "T", "O", "M", "K", "E"].sample(4)

    @solution = @pieces.sample(4)

    p @solution

    # @solution = ["R", "G", "B", "T"]

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

    input = []

    until valid_turn?(input)
      puts "Enter a piece."
      input = gets.chomp.upcase.chars
        unless valid_turn?(input)
          puts "Invalid Input"
        end
      
    end  
   @board.place_pin(input)
  end

  def valid_turn?(input)

    # p input.uniq.length
    # p input.length
    # p @board.pieces
    # p (input & @board.pieces).length

    input.uniq.length == 4 && input.length == 4 && (input & @board.pieces).length == 4

  #   4.times do |i|
  #     if 

  #     end

  #   end

  #   if 

  #   end

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
        game.render
        puts "You Won!"
        break
      end
    end

    

    unless game.victory?
      puts "You no win"
      print "The solution was: \s"
      4.times do |i|
        print (game.solution[i] + "\s")
      end
      puts
    end
  end

end


m = Mastermind.new

m.play

