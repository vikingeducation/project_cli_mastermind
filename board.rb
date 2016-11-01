class Board
  COLORS = %w(red yellow blue green black white)

  attr_accessor :board

  def initialize
    @board = []
  end

  def winning_sequence
    win = []
    4.times do
      win << COLORS.sample
    end
    win
  end

  def add_row(row)#(guess, number_of_exact_answers, number_of_right_colors)
    @board.push(row)
  end

  def render
    @board.each do |row|
      puts row
    end
  end

end

#Board
  #render
  #full?
  #number_of_right_answers
  #number_of_right_colors: green, blue, yellow, red, black, white
