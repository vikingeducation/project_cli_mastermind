#Control game play
class Hanoi
  def initialize(height)
    @board = Board.new(height)
    @player = Player.new(@board)
  end
    
  def play
    loop do 
      @player.get_coordinates
      puts @board[1]
     # break if game_over?
    end
  end
  
  def game_over?
  #  if ((@board[1].length == height-1) || (@board[2].length == height-1))
     # puts "Game over! You win!"
    #  true
   # end
  end

end

#Manages all player-related functionality
class Player
  def initialize(board)
    @board = board
  end

  def get_coordinates
    loop do
      @board.render
      coords = ask_for_coordinates
      if validate_coordinates?(coords)
        if @board.move_piece(coords)
          break
        end
      end
    end
  end

  def ask_for_coordinates
    puts "Enter your move in the format: start,stop (i.e. 1,3)"
    gets.strip.split(',').map(&:to_i)

  end

  def validate_coordinates?(coords)
    if coords.is_a?(Array) && coords.size == 2
      true
    else
      puts "Your coordinates are in the improper format."
    end
  end

end

#Maintains game board state
class Board
  def initialize(height)
      @height=height
      @board = [[],[],[]]
      (height-1).downto(0) do |i|
        @board[0] << i +1
      end
  end

  def render
    puts
    p "Tower 1: #{@board[0]}"
    p "Tower 2: #{@board[1]}"
    p "Tower 3: #{@board[2]}"
    puts
  end

  def move_piece(coords)
    start=coords[0]-1
    stop=coords[1]-1
    if piece_location_valid?(coords)
      @board[stop] << @board[start][-1]
      @board[start].pop
    else
      false
    end
  end

  def piece_location_valid?(coords)
    start=coords[0]-1
    stop=coords[1]-1
    #Check if within valid coordinates
    if (0..2).include?(start) && (0..2).include?(stop)
      #Check that you can legally move to the space
     true if @board[stop][-1].nil? || @board[stop][-1] > @board[start][-1] #valid move
    else
      false
    end
  end
end

h=Hanoi.new(3)
h.play




