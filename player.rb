# Manages all player related functionality
class Player
  attr_accessor :name

  # initialize
  def initialize(name = "Mystery Player", board)
    @name = name
    @board = board
  end

  # set_code
  def set_code
    # loop infinitely
    loop do
      # ask_for_code
      ask_for_code

      # IF validate_code_format is true
      if validate_code_format
        # IF code can be set on the board
        if @board.set_code
          # break the loop
          break
        end
      end
    end
  end

  # ask_for_code
  def ask_for_code
    # display message asking for code
    puts "#{@name}, please enter four colors to make a secret code."
    puts "You can choose from red, orange, yellow, green, blue and violet."
    puts "Please enter your code in the form color,color,color,color:"
    # pull code from command line
    gets.strip.split(","
  end

  # guess_code
    # loop infinitely
      # ask_for_guess
      # IF validate_code_format is true
        # IF guess can be placed on board
          # break the loop

  # ask_for_guess
    # display message asking for code
    # pull code from command line

  # validate_code_format
    # UNLESS code is in the proper format
      # display error message
end