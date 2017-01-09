class Player
  attr_accessor :player_name
  def initialize(player_name)
    @player_name = player_name
  end

  def validate_format(choice)
    return false unless choice.size == 4
    return true
  end
end

class HumanPlayer < Player
  def choose
    player_choice = Gui.make_chocie
    return player_choice if validate_format(player_choice)
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
