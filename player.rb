# Player class
class Player
  attr_accessor :guess
  def initialize
    @guess = []
  end

  def get_code
    puts "What is your guess?"
    @guess = gets.chomp.split(' ').map { |color| color.downcase }
  end

  def valid_input?
    correct_length? &&
    correct_colors?
  end

  def correct_length?
    @guess.length == 4
  end

  def correct_colors?
    @guess.all? { |peg| LEGAL_COLORS.include? peg }
  end



end
