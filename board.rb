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
    num_of_whites, num_of_blacks = [0, 0]
    @code.chars.each_with_index do |peg, index|
      if master_code[index] == peg
        num_of_blacks += 1
        master_code = set_first_matching_char(peg, '*', master_code)
      elsif master_code.include?(peg)
        num_of_whites += 1
        master_code = set_first_matching_char(peg, '*', master_code)
      end
    end
    @blacks, @whites = [num_of_blacks, num_of_whites]
  end


  def set_first_matching_char(match, replacement, word)
    match_index = word.chars.index(match)
    word = word.chars
    word[match_index] = "#{replacement}"
    word = word.join('')
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
