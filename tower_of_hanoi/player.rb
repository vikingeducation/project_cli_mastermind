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