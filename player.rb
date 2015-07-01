class Player #Inputs

  CODE_COLORS = %w(b r y p g o)

  def initialize(make_solution = false)
    @solution = make_code if make_solution
  end

  def make_code
    guess
  end

  def solution
    @solution
  end

  def guess
    input_valid = false
    until input_valid
      print "Enter your code in the format r,b,g,y : "
      raw_input = gets.strip
      exit if raw_input == "q"
      move = raw_input.split(",")
      input_valid = is_input_valid?(move)
      puts "Input is invalid. Please try again." unless input_valid
    end
    return move
  end

  def is_input_valid?(input)
    input.all?{ |item| CODE_COLORS.include?(item)}
  end

end