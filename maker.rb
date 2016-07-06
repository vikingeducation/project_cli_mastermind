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
    feedback_arr = []]

    copy = guess
    code_copy = @code
    copy.each_with_index do |ele, i|
      if code_copy[i] == copy[i]
        feedback_arr.push("r")
        copy[i] = "-"
      end
    end
    copy.each_with_index do |ele, i|
      if code_copy.include?(ele)
        feedback_arr.push "w"
        code_copy[code_copy.find_index(ele)] = "-"
      end
    end

  end


end
