class Board
  # initialize board
  def initialize
    # set up blank data structure
    @board = {}
    setup

    @turn = 1

    # set up colors
    POSSIBLE_COLORS = %W[R Y B G P W]

    # set up winning_combination
    @winning_solution = []
    generate_solution
  end

  # sets up empty board
  def setup
    (1..12).each do |num|
      @board[num] = %W[_ _ _ _]
    end
  end


  # render
  def render

    # loop through data structure
    @board.each do |key, move|
      puts move.join(' ')
    end 
  end

  # add_pegs(usr_input, turn)
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


  # print_feedback
    # red_feedback?
    # white_feedback?

  # red_feedback?
    # for each peg does it match the winning peg?
    # delete red matches from the placeholder arrays

    solution = ["R"]
    guess = ["G", "Y", "G"]

  # white_feedback?
    # receive arrays from red_feedback
    # unless peg is red_feedback?
      # for each peg is the color included in winning combination

  # generate_solution
    @winning_combination
    4.times do
      @winning_combination << @@possible_colors.sample
    end

  # winning_combination?
    # user input == 4 red_feedback?
  end