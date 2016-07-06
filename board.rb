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
    @blacks = count_black_keys
    @whites = count_white_keys
    @blacks.times { return_string += 'b' }
    @whites.times { return_string += 'w' }
    @game_board.last << return_string
  end

  def replace_matches(code)
    code.chars.map.with_index do |char, index|
      '' if @master_code[index] == char
    end
    code
  end

  #go through code and see if master code contains char.
  # if it does, remove the first instance of the match from master code

  def count_white_keys
    num_of_whites = 0
    master_code = @master_code
    code.chars.each do |char|
      if @master_code.include?(char)
        num_of_whites += 1
        index = master_code.chars.find_index(char)
        chars = master_code.chars
        chars.delete_at(index)
        master_code = chars.join('')
      end
    end
    num_of_whites
  end

  def count_black_keys
    num_of_blacks = 0
    @code.chars.each_with_index do |char, index|
      num_of_blacks += 1 if @master_code[index] == char
    end
    num_of_blacks
  end

  def render
    puts "Your master_code in the board class is #{@master_code}"
    @game_board.each do |line|
      line.first.chars.each { |char| print char + ' ' }
      print '*|* '
      line.last.chars.each  { |char| print char + ' ' }
      print "\n"
    end
    puts "-----------"
  end

end
