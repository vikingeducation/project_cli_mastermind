require './player.rb'

class Human < Player
  def make_a_guess
  	puts "What is your guess?"
    enter_row
  end

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

  def pick_solution
  	puts "Enter your secret code. Choose four colors"
  	enter_row
  end
end