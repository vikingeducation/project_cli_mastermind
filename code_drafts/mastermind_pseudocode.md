class Mastermind
# Set up the board [Board]
# Set up the codepegs [Board]
# Set up the keypegs [Board]
# Set up player
# Create default colour combination [Code]

#instructions
  Generate rules of the game if asked

#play
  #while loop for 12 turns
    # call the Board rendering method
    # ask player for colour combination
    # break the code if colour is guessed
      #Display Congratulations message
  # after 12 turns the player looses
    # Loosing message is displayed

#colour combination checker
  #check if the player's guess is matching the code

#feedback provider
  #provide feedback with code and key pegs

end

class Board
  #initialize the board
    #setup blank data structure
      #colours data
      #feedback data
      #Hash with 2D Array ie. {1 => [[R,B,G,Y], [w,w,e,b]]}

  #store guesses

  #render
    #loop through data structure
      #Display existing guesses if any, else blank

  #checks winning condition 
    #if colour 

  #provides feedback about colours only
    #loop
    #check if the remaining colours from provides feedback about colours and positions
      # if matches the one from the original code
        # generate white peg

  #provides feedback about colours and positions
    #loop
    # if colour macthes the original colour
      # if colour matches the position
        #generate black peg
        #generate array of ramainig not matching this criteria


end

class Code
  # creates code in colours
end

class Player
  # asking player for colour guess
    # Display message
    # Pull guess from CLI

  # validating correct user input

  # get_colours
    # loop infinately
      # asking player for colour guess
      # validating correct user input

end
