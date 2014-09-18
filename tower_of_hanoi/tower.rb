class TowerOfHanoi
  def initialize(number_of_tiles)
    @board = Board.new(number_of_tiles)
  end

  def play
    loop do
      @board.render
      @board.move_tile
      break if @board.check_completion
    end
    @board.render
    puts "You have solved the Tower of Hanoi!"
  end

end

class Board
  def initialize(height)
    @height = height
    @width = 6*height + 1
    @pegs = { "a" => (1..@height).to_a, "b" => Array.new(@height, 0), "c" => Array.new(@height, 0) }
  end

  def render
    puts top_border
    (0..@height-1).each do |position|
      puts side_border + display(@pegs["a"][position]) + empty_space + display(@pegs["b"][position]) + empty_space + display(@pegs["c"][position]) + side_border
    end
    puts info_row
    puts top_border
  end

  def display(value)
    if value > 0
      empty_space*(@height-value) + game_piece*(2*value-1) + empty_space*(@height-value)
    else
      empty_space*(2*@height-1)
    end
  end

  def top_border
    '-'*(@width)
  end

  def side_border
    '|'
  end

  def empty_space
    ' '
  end

  def game_piece
    '='
  end

  def info_row
    side_border + empty_space*(@height - 1) + 'A' + empty_space*(@height) + empty_space*(@height - 1) + 'B' + empty_space*(@height) + empty_space*(@height - 1) + 'C' + empty_space*(@height - 1) + side_border
  end

  def move_tile
    move = gets.chomp.downcase.split('')
    if proper_format?(move) && available_space?(move)
      displace(move)
    else
      puts "Invalid move"
    end
  end

  def proper_format?(move)
    (move.length == 2) && (move.all? { |x| ('a'..'c') === x })
  end

  def available_space?(move)
    terminal_index = (@pegs[move[1]].index { |item| item > 0 } || -1)
    initial_index = (@pegs[move[0]].index { |item| item > 0 } || -1)

    #check if there are pieces in the starting column
    @pegs[move[0]].last > 0 &&

    #check if the piece is smaller than the one it will be place on
    if @pegs[move[1]][-1] > 0
      @pegs[move[1]][terminal_index] > @pegs[move[0]][initial_index]
    else
      true
    end
  end

  def displace(move)
    start_column = @pegs[move[0]]
    final_column = @pegs[move[1]]

    #find the first non-0 in starting column and store its index
    start_index = start_column.index { |item| item > 0 }
    #find the last 0 in ending column and store its index value
    final_index = (final_column.length-1) - final_column.reverse.index { |item| item == 0 }

    #replace the last 0 in end column with first integer from starting column
    @pegs[move[1]][final_index] = @pegs[move[0]][start_index]
    #remove the first integer from 0
    @pegs[move[0]][start_index] = 0
  end

  def check_completion
    # unreadable code imminent
    unless @pegs["b"].include?(0) && @pegs["c"].include?(0)
      true
    end
  end
end

puts "How many tiles will you have?"
tiles = gets.chomp.to_i
game = TowerOfHanoi.new(tiles)
game.play