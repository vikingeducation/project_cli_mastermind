class Player
  attr_accessor :name

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

  def get_code
    loop do
      code = ask_for_code

      if validate_code_format(code)
        if @board.set_code(code)
          break
        end
      end
    end
  end

  def get_guess
    loop do
      guess = ask_for_guess

      if validate_code_format(guess)
        if @board.add_guess(guess)
          break
        end
      end
    end
  end

  private

  def ask_role_choice
    puts "Welcome to Mastermind."
    puts "Would you like to play as the codebreaker or codemaker?"
    print "Please enter 'codebreaker' or 'codemaker': "
    gets.strip
  end

  def ask_for_code
    puts
    puts "Please enter four colors to make a secret code."
    puts "You can choose from red, orange, yellow, green, blue and violet."
    print "Please enter your code in the form color,color,color,color: "

    gets.strip.split(",")
  end

  def ask_for_guess
    puts
    puts "Please enter four colors to guess the secret code."
    puts "You can choose from red, orange, yellow, green, blue and violet."
    print "Please enter your code in the form color,color,color,color: "

    gets.strip.split(",")
  end

  def validate_code_format(code)
    if code.is_a?(Array) && code.size == 4
      true
    else
      puts "Your code is in the improper format."
    end
  end
end