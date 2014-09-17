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






