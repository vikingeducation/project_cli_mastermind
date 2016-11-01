class ComputerPlayer < Player
  def get_code
    @board.code = generate_code
  end

  def get_choice  	
    @board.add_choice(generate_code)
  end

  private

	  def generate_code
	  	code = []
	    4.times do 
	      code << Mastermind::CHOICES.sample
	    end
	    code
	  end
end