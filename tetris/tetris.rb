# Your code here!

module Tetris

class Game
  def initialize
    player = Player.new
    board = Board.new
  end

  def start
    player.welcome

    play
  end

  def play
    loop do
      board.this_turn

      break if board.swamped?

      player.move
    end

    game_over
  end

  def game_over
    #scores

    puts "Thanks for playing Tetris!"
  end
end

class Player

  #welcome player

  #prompt for move

  #get high score

end

class Board
  def initialize
    #according to the game, a standard Tetris board is 10 cells wide
    #and at least 22 cells high, with the top two hidden

    #each cell can be FULL, EMPTY or have a PIECE moving through it

    #creates an initial piece on start at the top
  end
  
  # increments time by one, moving the piece down 
  # and calling methods that check on the results
  def this_turn
    #move piece the direction indicated

    #gravity: for each cell including piece 
    #(starting at the bottom and working up the screen)
      #if there is space below it, move it down by 1
    

    render

    #if piece has landed on another piece
      #freeze piece as FULL cell
      #create new piece way up high


    #for each full line, replace the whole thing with space
      #give player points for it

    #render again?

  end


  #displays the board right now with piece in right place
  def render
  end


  private

  #a board generates pieces


end


end