require_relative 'player'

class Human < Player
  attr_reader :name, :position, :code, :attempt
  def initialize
    puts "What is your name?"
    @name = gets.chomp
    puts "Would you like to play as the codebreaker or the codemaker?  "
    puts "1) Maker"
    puts "2) Breaker"
    @position = gets.chomp.to_i
  end

  def create_code
    puts "Please enter your 4 peg code with the initials of the colors you would like to select in order from left to right"
    @code = gets.chomp.split("")
  end

  def guess
    puts "Please enter your 4 peg guess with the initials of the colors you would like to select in order from left to right."
    @attempt = gets.chomp.split("")
  end

end
