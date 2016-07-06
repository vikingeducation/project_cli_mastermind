# separate methods that put messages and methods that act on data


class Player

  def initialize
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
    move_array.length == 4 && move_array.all?{ |x| COLORS.include?(x) }

  end

end