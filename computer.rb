require './player.rb'

class Computer < Player
  def make_a_guess
    guess = []
    4.times do
      guess << Peg::COLORS.sample
    end
    guess
  end

  def pick_solution 
    solution = []
    4.times do
      solution << Peg::COLORS.sample
    end
    solution
  end
end