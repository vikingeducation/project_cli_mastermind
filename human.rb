require './player.rb'

class Human < Player
  # returns array of color names (strings)
  def make_a_guess
  	puts "What is your guess?"
    enter_row
  end

  # returns array of color names (strings)
  def pick_solution
  	puts "Enter your secret code. Choose four colors"
  	enter_row
  end

  # gets and validates a string from player, 
  # returns array of color names (strings)
  def enter_row
    guess = gets.chomp.split(",")
    guess.each{ |color| color.strip! }
    if guess.length != 4
      return false
    end
    guess.each do |color|
      if !Peg::COLORS.include?(color)
        return false
      end
    end
    return guess
  end
end