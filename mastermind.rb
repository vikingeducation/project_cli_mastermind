COLORS = [
  "red",
  "blue",
]

[ 4 2 4 1 ]
COLORS[peg]

class Mastermind

  def initialize
    # assign codebreaker -> Player.create_player
    @codebreaker = Player.create_player
    # assign codemaker -> Player.create_player
    @codemaker = Player.create_player
    # create new board with setup from codebreaker
    @board = Board.new(@codebreaker)
  end

  def play

    loop do 
    # render board [board]
      @board.render
    # check for game over [Board]
      break if @board.game_over?
    # allow player to guess or quit and send to Board[Player]
      @board.move(@codebreaker.get_move)
    end

  end


  # end game
end
  
class Board
  # COLORS
  @game_turns = 12

  def initialize(player)
    # number of turns
    @player_turns = 0
    # array of moves
    @moves = []
    # get number of pegs [ask player]
    @pegs = player.get_pegs
    # get number of colors
    @colors = player.get_colors
  end

  # render
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  #  move
    # add move to board

  # give feedback
    # look at current turn
      # count number of correct, half-correct, and wrong
    # return

  #check for game over
    # did they win?
    # are the moves over?

  # win?

  # moves left?

end


class Player

  #initialize
    #name

  #get_move
    #prompt for move
    #input_code

  #make_answer
    #prompt for answer
    #input_code

  # get board conditions
    #get pegs
    #get colors (possible colors)

  # ask board for possible colors

  #create player
    # determine if computer or human and return new player

end
   

class Human < Player
  #input_code
    #ask for input
    #check for format

  def get_pegs
    
    pegs = 0
    until (4..6).include?(pegs)
      puts "How many pegs do you want to play with? Choose 4-6."
      pegs = gets.chomp.to_i
    end
    pegs

  end

  def get_colors

    colors = 0
    until (2..8).include?(colors)
      puts "How many colors do you want to play with? Choose 2-8."
      colors = gets.chomp.to_i
    end
    colors

  end

end
   

class Computer < Player
  #input_code
    #generate array of colors

  def get_pegs
    pegs = (4..6).sample
    puts "You're playing with #{pegs} pegs."
    pegs
  end

  def get_colors
    colors = (2..8).sample
    puts "You're playing with #{colors} colors."
    colors
  end
end



