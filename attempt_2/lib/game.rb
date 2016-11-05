require_relative 'player'
require_relative 'render'
require_relative 'board'

class Game

  def initialize(colors = ['r','o','y','g','b','p'], code_length = 4)  
    @colors = colors 
    @code_length = code_length
    @breaker = Human.new(@colors, @code_length)
    @maker = Computer.new(@colors, @code_length)
    @board = Board.new
    @results = { exact: 0, close: 0 }
  end

  def run 
    Render.welcome(@colors, @code_length)
    @board.code = @maker.make_code

    until code_deciphered? || no_turns_left?
      @breaker.add_turn
      Render.show_turn(@breaker.turns)
      Render.instructions(@colors, @code_length)
      @board.guess = @breaker.guess_code
      @results = @board.compare
      Render.game_board(@results, @board.guess)
    end
    
    Render.win if code_deciphered?
    Render.lose if no_turns_left?
  end

  private

  def code_deciphered? 
    @results[:exact] == 4
  end

  def no_turns_left? 
    @breaker.turns == 12
  end

end

# Run game

game = Game.new
game.run