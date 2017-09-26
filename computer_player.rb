class ComputerPlayer
  attr_reader :code

  def initialize
    @code = []
  end

  def create_code
    who_is_codemaker == 1
    4.times { @code << PEGS.sample }
    code
  end
end