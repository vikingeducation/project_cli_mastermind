#Control game play
class Hanoi
  def initialize(height)
    @turn_count=0
    @height=height
    @board = Board.new(height)
    @player = Player.new(@board)
  end
    
  def play
    loop do 
      @player.get_coordinates
      @turn_count+=1
      break if game_over?
    end
  end
  
  def game_over?
    if ((@board.board[1].length == @height) || (@board.board[2].length == @height))
      puts "###########"
      puts "Game over! It took you #{@turn_count} turns."
      puts "The optimum solution for this game was #{(2**@height)-1} turns."
      @board.render
      true
    end
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
    input=gets.strip
    exit if input.downcase == 'q'
    input.split(',').map(&:to_i)
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
  attr_reader :board, :turn_count
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
puts "###################################################"
puts "Welcome to the Tower of Hanoi!"
puts "There is a story about an Indian temple\
 in Kashi Vishwanath which contains a large room\
 with three time-worn posts in it surrounded by 64 golden disks.\
 Brahmin priests, acting out the command of an ancient prophecy,\
 have been moving these disks, in accordance with the\
 immutable rules of the Brahma, since that time.\
 According to the legend, when the last move \
 of the puzzle is completed, the world will end."
puts "\nWill YOU be the one to make the world end? Let's find out!"
puts "\n(At any time you may press 'q' to quit)"
puts "###################################################"
puts "\nChoose the tower height:"
height=gets.chomp.to_i
h=Hanoi.new(height)
h.play




