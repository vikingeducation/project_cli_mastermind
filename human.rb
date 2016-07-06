class Human < Player

  def get_guess
    puts ""
    guess = gets.chomp
  end

  def input_colors
    puts ""
    colors = gets.chomp
  end
end
