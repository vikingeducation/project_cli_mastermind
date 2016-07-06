class Board

  attr_writer :code, :master_code

  def initialize
    @game_board = []
  end

  def enter_guess
    @game_board << [@code]
  end

  def add_keys
    return_string = ''
    @blacks = count_black_keys
    @whites = count_white_keys
    @blacks.times { return_string += 'b' }
    @whites.times { return_string += 'w' }
    @game_board.last << return_string
  end

  def count_white_keys
    num_of_whites = 0
    @code.chars.each do |char|
      num_of_whites += 1 if @master_code.include?(char)
    end
    num_of_whites - @blacks
  end

  def count_black_keys
    num_of_blacks = 0
    @code.chars.each_with_index do |char, index|
      num_of_blacks += 1 if @master_code[index] == char
    end
    num_of_blacks
  end

  def render
    @game_board.each do |line|
      line.first.chars.each { |char| print char + ' ' }
      print '*|* '
      line.last.chars.each  { |char| print char + ' ' }
      print "\n"
    end
    puts "-----------"
  end

end