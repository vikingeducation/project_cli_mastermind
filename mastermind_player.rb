class Player
  attr_accessor :player_name
  def initialize(player_name)
    @player_name = player_name
  end

  def validate_format(choice)
    return true if choice.size == 4
      Gui.redo_selection
    return false
  end
end

class HumanPlayer < Player
  def choose
    begin
      player_choice = Gui.make_chocie
    end until validate_format(player_choice)
    return player_choice
  end
end

class CpuPlayer < Player
  def choose
    player_choice = []

    4.times do
      player_choice << %w(B G O P R Y).freeze.sample
    end
    return player_choice if validate_format(player_choice)
  end
end
