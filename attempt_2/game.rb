class Game

  def initialize  
    @colors = ['r','o','y','g','b','p']
    @board = Board.new(@colors)
    @breaker = Human.new(@colors)
    @maker = Computer.new(@colors)
  end

  def run 
    Render.welcome(@colors)
    Render.instructions(@colors)
    maker.make_code
    until code_broken? || no_turns_left?
      guess = breaker.guess
      results = 
      Render.game_board(guess)
    end
  end

  private

  def code_broken? 
    maker.code == breaker.code
  end

  def no_turns_left? 
    breaker.turns > 12
  end

end