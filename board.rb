class Board

  def initialize
    @board = []
  end

  def render
  end

  def add_guess(guess)
    @board << guess
    get_feedback
  end

  def close_color_count
    @code.each do
    end
  end

  def exact_color_count
  end

end
