# The input module is responsible for allowing the player to put in choices.
module Input
  COLORS = ["B", "G", "R", "O", "Y", "P" ]

  # def if_save(string)
  #   if string.downcase == "save"
  #     return "save"
  #   end
  # end

  # Get choice returns a string if they want to save,
  # Otherwise, it returns an array with their choices.
  def get_choice
    choice_input = gets.chomp.upcase

    if choice_input.downcase == "save"
      return "save"
    end

    unless valid_choice?(choice_input)
      until valid_choice?(choice_input)
        puts "Invalid choice, please try again!"
        choice_input = gets.chomp.upcase
        if choice_input.downcase == "save"
          return "save"
        end
      end
    end

    return choice_input.split
  end

  # Choices must be 4 characters seperated by a space.
  # Rejects any inputs that have non-color characters.
  def valid_choice?(choice)
    return false if choice.split.length != 4
    choice.split(" ").all? { |char| COLORS.include?(char) }
  end

end