Set up the game initially [Mastermind]
  Create a game board [Board]
  Create players [Players]

Start the game loop [Mastermind]
  Render the board [Board]
  Ask for and validate players peg choices [Player]
  If the game should end [Mastermind]
    Display the proper message
    Stop looping
  Else
    Return feedback about pegs [Board]
    Keep looping [Mastermind]

# controls the game play
class Mastermind
  # initialize
    # set up the board
    # set up player

  # play
    # loop twelve times
      # render board
      # ask for user input
      # break loop if game is over

    # loser message
      # puts out a message
      # puts out winning combination

  # check_victory
    # a winning_combination?
      # display a victory message
end

# Manages player functionality
class Player
  # initialize

  # get_input
    # loop infinitely
      # ask_for_input
      # IF validate_input is true
        # break loop

  # ask_for_input
   # Display message asking for input
   # pull input form command line

  # validate_input
    # unless input are in the proper format(colors are valid)
      # display error

end

# Maintains game board state
class Board
  # initialize board
    # set up blank data structure
    # set up winning_combination
    # set up all possible colors

  # render
    # loop through data structure
      # display an existing marker if any, else blank

  # add_pegs
    # If input_valid?
      # place pegs
    # else
      # display error message

  # input_valid?
    # input_color_valid?
    # input_length_valid?

  # input_color_valid?
    # If are the inputs included in all possible colors?

  # input_length_valid?
    # input length correct

  # generate_feedback
    # compare_input
    # print possible feedbacks

  # compare_input
    

  # print_feedback
    # red_feedback?
    # white_feedback?

  # red_feedback?
    # for each peg does it match the winning peg?

  # white_feedback?
    # unless peg is red_feedback?
      # for each peg is the color included in winning combination






13 => ["R", "Y", "G", "B"]
4 => ["_", "_", "_"]
3 => 
2 => ["R", "B", "Y", "G"]
1 => ["R", "B", "Y", "G"]
x = 2

  (0..3).each do |idx|
    if hash[x][idx] == hash[13][idx]
  end


  hash[x].each do |ele|
    if hash[13].include?(ele)
      white_counter +=1
    end

