class Computer < Player

  def get_guess
    guess=random_colors
    @board.update_display(guess)
    sleep(1)
  end
  def input_colors
    @key=random_colors
    @board.set_key(@key)
  end

  def random_colors
    result=[]
    4.times do
      result << @board.VALID_COLORS.sample
    end
    result
  end

end