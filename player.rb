require_relative 'board.rb'

class Player

  def initialize(board)
    @board = board
  end

  def get_input
    loop do
      input = ask_for_input
      return input if validate_input_format(input)
    end
  end

  def ask_for_input
    puts "#{@name}, enter your code colors (r, y, g, b, p, o) in sequence in the form w,x,y,z"
    gets.strip.split(",")
  end

  def validate_input_format(input)
    if input.length == 4 && valid_color?(input)
      true
    else
      puts "Your code is in the improper format!"
    end
  end

  def valid_color?(input)
    input.all? {|x| %w[r y g b p o].include?(x)}
  end

end

# def test
#   player = Player.new(Board.new)
#   input = player.get_input
#   puts input
# end

# test

