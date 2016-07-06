# Player class
class Player

  def initialize
    @guess = []
  end

  def get_code
    puts "What is your guess?"
    @guess = gets.chomp.split(' ').downcase
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
