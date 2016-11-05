class Player

  attr_reader :code
  attr_accessor :turns

  def initialize(colors, code_length)
    @turns = 0
    @code = "" 
    @colors = colors
    @code_length = code_length
  end

end

class Human < Player

  # def make_code
  # end

  def guess_code
    @code = ""
    loop do
      @code = gets.chomp
      break if valid_input?
      puts "Please enter #{@code_length} letters from #{@colors}."
    end
    @code
  end

  def add_turn
    @turns += 1
  end

  private

  def valid_input?
    return false if @code.length != @code_length
    return false unless input_has_colors_only?
    true
  end

  def input_has_colors_only?
    @code.split("").all? { |color| @colors.include?(color) }
  end

end

class Computer < Player

  def make_code
    @code = ""
    @code_length.times { @code += @colors.sample }
    @code 
  end

  # def guess_code
  # end

end


