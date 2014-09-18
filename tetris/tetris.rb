# Your code here!

module Tetris

class Game
  def initialize
    @board = Board.new
    @player = Player.new(board)

  end

  def start
    @player.welcome

    @play
  end

  def play
    loop do
      @board.render

      break if @board.swamped?

      @player.move
      
      #TODO: later, if realtime, consider waiting a period of time here?
    end

    game_over
  end

  def game_over
    #scores

    puts "Thanks for playing Tetris!"
  end
end

class Player
  
  def initialize(board)
    @board = board
  end

  def welcome
    puts "Welcome to M-TRIS, Michael Alexander's block-based puzzle game clone."
  end

  #prompt for move
  def move
  end

  #get high score

end

class Board

    #according to the game, a standard Tetris board is 10 cells wide
    #and at least 22 cells high, with the top two hidden
    #each cell can be FULL, SPACE or have a PIECE moving through it
  def initialize
    @cells = Array.new(10) { Array.new(22, :space) }
    new_piece
  end
  
  # public method that leads to the objects getting displayed for 
  # this turn. combines the calculations for movement and actually
  # displaying the pieces
  
  def render

    display


    run_gravity
    check_landings

    #for each full line, replace the whole thing with space
      #give player points for it

    # MAYBE: display again? still thinking about the flow here.

  end

  # game end condition. returns true if a full cell is ever found
  # on the top visible row
  def swamped?
    (0..num_columns-1).each do |column|
      return true if @cells[column][num_visible_rows - 1] == :full
    end
    false
  end


  private
  
  

  # displays the board right now with piece in right place
  # displays only the bottom 20 rows of pieces because 
  # the top two are meant to be hidden, like real tetrises
  def display
    p @cells
  end
  
  
 # gravity: for each cell including piece 
 # (starting at the bottom and working up the screen)
 # if there is space below it, move it down by 1

  def run_gravity
    
    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        
        next if row_num == num_rows - 1 #skip top column
      
        if cell == :space
          swap_cells(col_num, row_num)
        end
      
      end
    end
      
  end
  
  
  #if piece has landed on a :full cell
  #freeze piece as :full cell
  #create new piece way up high
  def check_landings
    
    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        if row_num == 0 && cell == :piece
          cell = :full
        elsif row_num == 0
          next
        elsif cell == :piece && @cells[row_num-1][col_num] == :full
          cell = :full
        end
      
      end
    end    

    
    new_piece if @cells.none? { |column| column.include? (:piece) }
  
  end
  
  #swaps a cell, specified by index, with the cell above it
  def swap_cells(column, row)
    @cells[column][row], @cells[column][row+1] = @cells[column][row+1], @cells[column][row]
  end
  
  # create new single-block piece at top of board in a random row
  def new_piece
    column = rand(num_columns)
    
    @cells[column][num_rows - 1] = :piece
  end
  
  def num_columns
    @cells.size
  end

  def num_rows
    @cells[0].size
  end
  
    
  def num_visible_rows
    @cells[0].size - 2
  end
  
  def num_visible_columns
    @cells.size - 2
  end

end


end
