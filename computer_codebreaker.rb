class ComputerCodebreaker < HumanCodebreaker

  def initialize(colours, board)
    super(colours, board)
    @stored_guesses = []
  end

  protected

  def validate_combination(combination)
    true if @stored_guesses.select {|colour| colour == combination}.empty?
  end

  def ask_for_combination
    combination = []
    while combination.size != 4
      random_number = @colours[rand(0..5)]
      combination << random_number
      @stored_guesses << combination if combination.size == 4
    end
    combination
  end

end