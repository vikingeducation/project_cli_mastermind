class Player

  attr_reader :turns, :code

  def initialize
    @turns = 0
    @code = nil
  end

end

class Human < Player

  def make_code
  end

end

class Computer < Player

  def make_code
  end

end