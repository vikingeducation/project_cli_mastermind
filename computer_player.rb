class ComputerPlayer < Player
  def get_code
    code = []
    4.times do 
      code << Mastermind::CHOICES.sample
    end
    @board.code = code
  end
end