class Board

  COLORS = %w(red yellow blue green black white)

  def winning_sequence
    win = []
    4.times do
      win << COLORS.sample
    end
    win
  end

end

#Board
  #render
  #full?
  #number_of_right_answers
  #number_of_right_colors: green, blue, yellow, red, black, white
