class Maker < Player
  attr_reader :fb_board, :name, :code

  def initialize
    @fb_board = Board.new
    @name = "Code Maker"
    @code = []
  end

  def set_code
    @code = get_input
  end

  def feedback(guess)
    feedback_arr = Array.new(4)

    guess.each_with_index do |ele, i|

      feedback_arr[i] = "w" if @code.include? ele
      feedback_arr[i] = "r" if ele == @code[i]

    end

  end
end
