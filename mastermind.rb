

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
    @player1 = Player.new
    $COLORS = %w[orange green red blue purple yellow]

  end
  
  def play
    until over?
      @turns += 1
      render
      @player1.get_move


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
    arr = $COLORS
    code = []
    code = 4.times {code << arr.sample}
    #

  end

  def current_board
    contains an array of the current placed colored pegs
    gets passed the player move


  end


end




class Player

  def initilzie
    @move_holder = ""
  end

  def get_move
    puts "Please type the color of pegs you want to place."
    puts "For example: 'red, green, blue, blue' "
    move = gets.chomp.downcase
    valid_move?(move) ? @move_holder = move : get_move
  end

  def valid_move?(move)
    # valid move will after being split at every comma and space be an array
    # where each item a color.
    move_array = move.split(", ")
    move_array.length == 4 && move_array.all?{ |x|$COLORS.include?(x) }

  end

end