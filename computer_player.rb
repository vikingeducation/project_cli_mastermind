require './config'

class ComputerPlayer < Player
  def make_code
    code = []
    4.times do 
      code << Mastermind::CHOICES.sample
    end
    code
  end
end