class Game

  def initialize  
    @board = Board.new
    breaker = Human.new
    maker = Computer.new
  end

  def run 
    welcome_message
    display_instructions

    maker.make_code
    until code_broken? || no_turns_left?

    end
  end

  def code_broken? 
    maker.code == breaker.code
  end

  def no_turns_left? 
    breaker.turns > 12
  end

end