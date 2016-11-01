require './player'
class HumanPlayer < Player

  def get_choice
    loop do 
      choice = ask_for_choice

      if valid_choice?(choice)
        @board.add_choice(choice)
        break
      end
    end
  end

  def ask_for_choice
    puts "Try to guess the four letter code from A,B,C,D,E,F: (ie ABCD)"
    print "> "
    gets.strip.upcase.chars
  end

  def valid_choice?(choice)
    return false unless choice.length == 4
    choice.all? do |char|
      Mastermind::CHOICES.include?(char)
    end
  end
end






