require 'pry'

class Player
 COLORS = ["B", "P", "R", "O", "G", "Y"]
end

class AI < Player

  def initialize
  end

  def generate_code
    code = []
    4.times { code << COLORS.sample }
    code
  end

end

class Human < Player
  
  def initialize
  end

  def place_guess
    loop do 
      puts "What would you like to put into this row?"
      puts "Format your answer as 'B G G R'."
      guess = gets.chomp
      guess = guess.upcase.split(" ")
      break if valid_guess?(guess)
    end
    guess
  end

  def valid_guess?(guess)
   return true if guess.all? { |item| COLORs.include?(item) } && guess.size == 4
    false
  end

end