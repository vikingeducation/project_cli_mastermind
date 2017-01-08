class Mastermind
  MAX_TURN_COUNT = 12

  def initialize(player)
    @player = player
    @turns = 1
  end

  def game_check
    return @turns < MAX_TURN_COUNT
  end

  def play
    loop do
      Gui
    end
  end
end
