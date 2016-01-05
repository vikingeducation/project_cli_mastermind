#keeps track of game state and can render states
class GameBoard
  #each row has 4 big codepegs 4 small keypegs
  def initialize
    @board = Array.new(12) { Array.new(8,"o") }
    @answer_key = Array.new(4, "o")
  end

  #prints board
  def render
    row_index = 1
    @board.each do |row|
      print "#{row_index}"
      row_index += 1
      row.each do |col|
        print "#{col} "
      end
      puts
    end
    puts
  end

end
