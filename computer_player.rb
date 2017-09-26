class ComputerPlayer
  attr_reader :code
  attr_accessor :guess

  def initialize
    @code = []
    @guess = []
  end

  def create_code
    4.times { self.code << PEGS.sample }
    code
  end

  def make_guess 
    self.guess = []
    4.times { self.guess << PEGS.sample }
    guess
  end
end