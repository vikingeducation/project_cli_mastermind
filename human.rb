class Human < Player

  def get_guess
    puts "Enter your guess in this format: r,g,y,b"
    guess = gets.chomp.split(",").map{|color|color.to_sym}
    @board.update_display(guess)
  end

  def input_colors
    puts ""
    colors = gets.chomp
  end
end
