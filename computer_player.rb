class ComputerPlayer < Player
  def initialize(name = "Computer", board)
    super
  end

  private

  # ask for code to set secret code
  def ask_for_code
    code = []

    until code.size == 4
      valid_colors = @board.valid_colors
      random_color = valid_colors[rand(valid_colors.count)]
      code.push(random_color)
    end

    code
  end

  # ask_for_guess
  def ask_for_guess
    code = []

    until code.size == 4
      valid_colors = @board.valid_colors
      random_color = valid_colors[rand(valid_colors.count)]
      code.push(random_color)
    end

    code
  end

end