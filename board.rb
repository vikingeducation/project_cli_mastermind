class Board
  attr_accessor :code, :master_code

  def initialize
    @game_board = []
  end

  def enter_guess
    @game_board << [@code]
  end

  def add_keys
    return_string = ''
    set_blacks_whites
    @blacks.times { return_string += 'b' }
    @whites.times { return_string += 'w' }
    @game_board.last << return_string
  end

  def set_blacks_whites
    master_code = @master_code
    code = @code
    num_of_whites = 0
    num_of_blacks = 0
    @code.chars.each_with_index do |peg, index|
      if master_code[index] == peg
        num_of_blacks += 1
        next
      elsif master_code.include?(peg)
        num_of_whites += 1
        match_index = master_code.chars.index(peg)
        master_code = master_code.chars
        master_code[match_index] = '*'
        master_code = master_code.join('')
      end
    end
    @blacks = num_of_blacks
    @whites = num_of_whites
  end

  def render
    @game_board.each do |line|
      line.first.chars.each { |char| print char + ' ' }
      print '*|* '
      line.last.chars.each { |char| print char + ' ' }
      print "\n"
    end
    puts '-----------'
  end
end
