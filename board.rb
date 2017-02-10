class Board
  attr_reader :display_arr

  def initialize
    start_board =  "_  _  _  _"
    puts start_board
    @display_arr = []
  end

  def render(attempt)
    display = attempt.join("  ")
    @display_arr << display
    puts @display_arr
  end

end
