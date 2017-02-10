require_relative 'player'

class Machine < Player
  attr_reader :mach_pos, :code, :attempt
  def initialize(position)
    if position == BREAKER
      @mach_pos = "maker"
    else
      @mach_pos = "breaker"
    end
  end

  def greeting(name, mach_pos)
    puts "Hello #{name}, I'm Conrad.  I will be the code#{mach_pos}.  The codebreaker will have 12 attemps with feedback after each of the first 11 to deduce the correct color and order of the codemaker's pegs.  The color possibilities are Red, Orage, Yellow, Green, Blue and Purple; represented by their first initial.  Feedback that a peg is Close means that it is the correct color but in the wrong position.  Feedback that the peg is Exact means that it is both the correct color and position.  Let's play!"
  end

  def create_code
    @code = []
    4.times do |x|
      x  = ["r", "o", "y", "g", "b", "p"].sample(1).join(" ")
      @code << x
    end
  end

  def guess
    #will improve guessing later by using feedback
    @attempt = ["r", "o", "y", "g", "b", "p"].sample(4)
  end

end
