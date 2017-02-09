class Player
  attr_reader :guess

  def initialize
    @guess = nil
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