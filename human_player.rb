require './config'

class HumanPlayer < Player

  def get_choice
    loop do 
      choice = ask_for_choice

      if valid_choice?(choice)
        @board.add_choice(choice)
        break
      end
      Renderer.invalid_choice_error
    end
  end

  def ask_for_choice
    Renderer.ask_for_choice
    gets.strip.upcase.chars
  end

  def valid_choice?(choice)
    return false unless choice.length == 4
    choice.all? do |char|
      Mastermind::CHOICES.include?(char)
    end
  end
end






