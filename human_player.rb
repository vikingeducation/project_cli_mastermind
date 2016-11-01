class HumanPlayer < Player

  def get_code
    @board.code(get_input)
  end

  def get_choice
    @board.add_choice(get_input)
  end

  def get_input
     loop do 
      input = ask_for_input

      if valid_input?(input)
        return input
      end
      Renderer.invalid_input_error
    end
  end

  def ask_for_input
    Renderer.ask_for_input
    gets.strip.upcase.chars
  end

  def valid_input?(input)
    return false unless input.length == 4
    input.all? do |char|
      Mastermind::CHOICES.include?(char)
    end
  end


end






