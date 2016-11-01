class HumanPlayer < Player
  
  def get_input
     loop do 
      input = ask_for_input

      if valid_input?(input)
        return input
      end
      Renderer.invalid_input_error
    end
  end

    private

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






