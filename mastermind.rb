
=begin

 game class
  play method
  number of players
  gameloop
  turns counter 
  game_over?


player class
  initiate secret_code
  get_move method


human class
  inherit from player

computer class
  inherit from player

 board class
  generate_code
  render(drawing)
  feedback algo
  win?
  lose?

 peg class
  color

  secret_code class
=end

class Game 

  def initialize
    @board = Board.new
    @secret_code = @board.generate_code
    @turns = 0
  end
  
  def play
    until over?

    end
  end

  def over?
    @turns == 12 || @player_guess == @secret_code
  end

end

class Board
  def initialize

  end

  def generate_code
    #orange, green, red, blue, purple, yellow
    arr = %w[orange green red blue purple yellow]
    code = []
    code = 4.times {code << arr.sample}
  end


end


