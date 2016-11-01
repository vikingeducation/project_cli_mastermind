class Board 
  MAX_TURNS = 12 
  attr_writer :code

  def initialize
    @code = nil
    @board_guesses = []
    @turn_count = 0
  end

  def render
  end

  def add_choice(choice)
    @board_guesses << choice
    @turn_count += 1
  end

end


