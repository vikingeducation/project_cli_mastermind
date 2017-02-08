# Manages all player related functionality
class Player
  attr_accessor :name

  # initialize
  def initialize(name = "Mystery Player", board)
    @name = name
    @board = board
  end

  def get_role_choice
    loop do
      role = ask_role_choice

      if role == "codebreaker" || role == "codemaker"
        return role
      else
        puts "Invalid selection."
      end
    end
  end

  # get secret code
  def get_code
    # loop infinitely
    loop do
      # ask_for_code
      code = ask_for_code

      # IF validate_code_format is true
      if validate_code_format(code)
        # IF code can be set on the board
        if @board.set_code(code)
          # break the loop
          break
        end
      end
    end
  end

  # get guess
  def get_guess
    # loop infinitely
    loop do
      # ask_for_guess
      guess = ask_for_guess

      # IF validate_code_format is true
      if validate_code_format(guess)
        # IF guess can be placed on board
        if @board.add_guess(guess)
          # break the loop
          break
        end
      end
    end
  end

  private

  # ask game settings
  def ask_role_choice
    puts "Welcome to Mastermind."
    puts "Would you like to play as the codebreaker or codemaker?"
    print "Please enter 'codebreaker' or 'codemaker': "
    gets.strip
  end

  # ask for code to set secret code
  def ask_for_code
    # display message asking for code
    puts
    puts "Please enter four colors to make a secret code."
    puts "You can choose from red, orange, yellow, green, blue and violet."
    print "Please enter your code in the form color,color,color,color: "
    # pull code from command line
    gets.strip.split(",")
  end

  # ask_for_guess
  def ask_for_guess
    # display message asking for guess
    puts
    puts "Please enter four colors to guess the secret code."
    puts "You can choose from red, orange, yellow, green, blue and violet."
    print "Please enter your code in the form color,color,color,color: "
    # pull code from command line
    gets.strip.split(",")
  end

  # validate_code_format
  def validate_code_format(code)
    # UNLESS code is in the proper format
    if code.is_a?(Array) && code.size == 4
      true
    else
      # display error message
      puts "Your code is in the improper format."
    end
  end
end