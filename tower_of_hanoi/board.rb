
#Maintains game board state
class Board
  attr_reader :board, :turn_count
  def initialize(height)
      @height=height
      @board = [[],[],[]]
      (height-1).downto(0) do |i| #provide the initial values
        @board[0] << i +1
      end
  end

  def render
    @height.downto(0) do |i|
      0.upto(2) do |j|
        if @board[j][i]
          print  (':D '*@board[j][i]).to_s.ljust(10)
        else
          print " ".ljust(10)
        end
      end
      puts ""
    end
    puts "--------" * @height
    1.upto(3) do |i|
      print "Tower #{i}".ljust(10)
    end
    puts ""

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