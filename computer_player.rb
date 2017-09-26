class ComputerPlayer
  attr_reader :code

  def initialize
    @code = []
  end

  def create_code
    4.times { @code << PEGS.sample }
    code
  end
end