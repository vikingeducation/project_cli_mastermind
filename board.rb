class Board
  attr_reader :ai_colors

  def generate_pegs
    @ai_colors = ['R', 'G', 'B', 'Y'].shuffle
  end
end
