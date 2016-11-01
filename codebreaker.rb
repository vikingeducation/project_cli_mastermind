class Codebreaker

  def make_guess
    puts "Enter pegs in the format: red green blue yellow"
    guess = gets.chomp
    @guess_array = guess.split(' ')
    if valid_input?
      @guess_array
    else
      make_guess
    end
  end

  def valid_input?
    right_number_of_pegs? && correct_colors?
  end

  def right_number_of_pegs?
    @guess_array.size == 4
  end

  def correct_colors?
    @guess_array.all? do |color|
      Board::COLORS.include?(color)
    end
  end
end
