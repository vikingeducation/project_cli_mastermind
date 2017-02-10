class Player
  attr_reader :guess, :role

  def initialize
    @guess = nil
    @role = nil
  end

  # prompts the user for his next guess
  def make_guess
    loop do
      print "Please enter your guess: "
      guess = gets.chomp.downcase

      if Mastermind::QUIT_OPTIONS.include?(guess)
        @guess = guess
        break
      end

      formatted_guess = format_guess(guess)
      if valid_guess?(formatted_guess, Mastermind::CODE_COLORS)
        @guess = formatted_guess
        break
      else
        puts "That guess is invalid. Please try again."
      end
    end
  end

  # checks what role the player wants to be
  def set_role
    loop do
      puts "Please enter what role you'd like to be."
      puts "You can either (b)reak the code, or (s)et the code."
      print "Please enter 'b' or 's': "

      input = gets.chomp.downcase

      if input == "b"
        @role = :codebreaker
        break
      elsif input == "s" 
        @role = :codesetter
        break
      else
        puts "That is an invalid role. Please try again."
        puts
      end
    end
  end

  private

  # formats player guess into an expected format
  def format_guess(guess)
    guess.split(/\W+/).map { |color| color.downcase.to_sym }
  end

  # checks if the player's guess is valid
  def valid_guess?(guess, code_colors)
    guess.length == 4 && guess.all? { |color| code_colors.include?(color) }
  end
end
