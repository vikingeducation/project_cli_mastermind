class Maker < Player
  attr_reader :fb_board, :name

  def initialize
    @fb_board = Board.new
    @name = "Code Maker"
  end

  def set_code
    get_code_input
    set game code

  end

  def feedback

  end
end
