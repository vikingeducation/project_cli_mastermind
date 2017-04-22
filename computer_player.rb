class ComputerPlayer

  attr_reader :hidden_code, :guess

  def initialize
  end

  # make code
  def hidden_code
    options = ["blue", "red"]
    code = []
    4.times do
      code << options.sample
    end
    code
  end


  # break code
  def guess
    options = ["blue", "red"]
    @guess = []
    4.times do
      @guess << options.sample
    end
    @guess
  end

end # end of class
