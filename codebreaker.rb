class Codebreaker

  def make_guess
    puts "Enter pegs in the format: red green blue yellow"
    guess = gets.chomp
    guess_array = guess.split(' ')
    make_guess until valid_input?(guess_array)
  end

  def valid_input?(guess)
    right_number_of_pegs? && correct_colors?
  end

  def right_number_of_pegs?
    #
  end

  def correct_colors?
    colors.all? do |color|
      COLORS.include?(color)
    end
  end
end

#Codebreaker
  # enter_pegs
  #valid_input?
  #right number of pegs
  #make_guess
  # correct colors?
