class Player
  include PegColors
  attr_accessor :player_name, :player_choice
  def initialize(player_name)
    @player_name = player_name
  end

  private
  
  def validate_format(choice)
    return true if choice.size == 4
    Gui.redo_selection
    return false
  end

  def validate_choice(choice)
    all_correct_peg = true
    choice.each do |peg|
      all_correct_peg = false unless self.peg_colors.include?(peg)
    end
    if all_correct_peg
      return true
    else
      Gui.redo_selection
      return false
    end
  end
end

class HumanPlayer < Player
  def choose
    begin
      player_choice = Gui.make_chocie
    end until validate_format(player_choice) && validate_choice(player_choice)
    return player_choice
  end

  def pick_code
    code_to_break = []
    Gui.player_created_code
    code_to_break = self.choose
    return code_to_break
  end
end

class CpuPlayer < Player
  def choose
    code_to_break = []

    4.times do
      code_to_break << self.pick_random_pegs
    end
    code_to_break
  end

  def pick_code
    code_to_break = []
    4.times do
      code_to_break << self.choose
    end

    return code_to_break
  end
end
