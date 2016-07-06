# Initialize board [Mastermind]
  # getting difficulty, # of players, etc. [Mastermind]
  # a player makes the code [Player]
# Play loop [Mastermind]
  # render board [board]
  # allow player to guess or quit [Player]
  # check for game over [Board]
  # feedback [Board]









class Mastermind

  #initialize
    # assign players
    # ask board for set up

  #play
    # render board [board]
    # check for game over [Board]
    # allow player to guess or quit [Player]

end
  
class Board

  # initialize
    # number of turns
    # array of moves
    # who the codebreaker and codemaker is
    # get number of pegs
    # get number of colors

  # render
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  # give feedback
    # look at current turn
      # count number of correct, half-correct, and wrong
    # return

  #check for game over
    # did they win?
    # are the moves over?

end


class Player

  #initialize
    #name

  #make_code




end
   

class Human < Player
  #make_code
    #ask for input
    #check for format

end
   

class Computer < Player
  #make_code
    #generate array of colors
end



