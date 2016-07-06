COLORS = [
  "red",
  "blue",
]

[ 4 2 4 1 ]
COLORS[peg]

class Mastermind

  #initialize
    # assign codebreaker -> Player.create_player
    # assign codemaker -> Player.create_player
    # create new board with setup from codebreaker

  #play
    # render board [board]
    # check for game over [Board]
    # allow player to guess or quit [board]

  # end game
end
  
class Board
  # COLORS
  # TURNS

  # initialize
    # number of turns
    # array of moves
    # who the codebreaker and codemaker is
    # get number of pegs [ask player]
    # get number of colors

  # render
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  # make move
    # ask player for move

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

  #make_code

  # get board conditions
    #get pegs
    #get colors (possible colors)

  # ask board for possible colors

  #create player
    # determine if computer or human and return new player

end
   

class Human < Player
  #make_code
    #ask for input
    #check for format

  # get pegs

  # get colors

end
   

class Computer < Player
  #make_code
    #generate array of colors

  # get pegs

  # get colors
end



