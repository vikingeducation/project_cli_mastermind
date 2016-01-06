class Board
  attr_accessor :turn
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

  # add_pegs(usr_input)
  def add_pegs(usr_input)
    # If input_valid?
    if input_valid?(usr_input)
      # place pegs
      board[turn] = usr_input
      @turn += 1
    else
      puts "Invalid input."
    end
  end

  # input_valid?
  def input_valid?(usr_input)
    input_color_valid?(usr_input) && input_length_valid?(usr_input)
  end
    
  # input_color_valid?
  def input_color_valid?(usr_input)
    # If are the inputs included in all possible colors?
    usr_input.all? { |chr| POSSIBLE_COLORS.include?(chr) }
  end

  # input_length_valid?
  def input_length_valid?(usr_input)
    # input length correct
    usr_input.length == 4
  end

  # generate_feedback
  def generate_feedback(usr_input)
    solution = @winning_solution
    guess = usr_input
    accuracy = []
    # compare_input
    # print possible feedbacks
  end


  # print_feedback
    # red_feedback?
    # white_feedback?

  # red_feedback?
    # for each peg does it match the winning peg?
    # delete red matches from the placeholder arrays

solution = ["G", "R", "B", "Y"]
guess = ["G", "G", "R", "P"]

def feedback(usr_input)
  usr_input.each_with_index do |val, index|
    if val == @winning_combination[index] && accuracy[index] != "r" && usr_input_index != index
      accuracy << "y"
    end
  end
end

accuracy = ["r", "y"]

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