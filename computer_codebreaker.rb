class ComputerCodebreaker < HumanCodebreaker

  def initialize(colours, board) #testing
    super(colours, board)
    @stored_guesses = []
  end

  protected

  def ask_for_combination
    combination = []
    4.times {|colour_index| combination << @colours[rand(0..5)]}
    combination
  end

end