require './player.rb'

class Computer < Player
  def make_a_guess
    guess = []
    4.times do
      guess << Peg::COLORS.sample
    end
    guess
  end
end