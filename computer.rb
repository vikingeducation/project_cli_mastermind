require './player.rb'

class Computer < Player
  # returns an array of color names (strings)
  # used when the player is in the codebreaker role
  def make_a_guess
    guess = []
    4.times do
      guess << Peg::COLORS.sample
    end
    guess
  end

  # returns an array of color names (strings)
  # used when the player is in the codemaker role, 
  # to choose the secret code
  def pick_solution 
    solution = []
    4.times do
      solution << Peg::COLORS.sample
    end
    solution
  end
end