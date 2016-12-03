class ComputerPlayer < Player

  def get_input
  	code = []
    4.times do 
      code << Mastermind::CHOICES.sample
    end
    code
  end
end