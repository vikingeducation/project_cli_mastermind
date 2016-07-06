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

  #go through code and see if master code contains char.
  # if it does, remove the first instance of the match from master code

  def count_white_keys
    num_of_whites = 0
    master_code = remove_black_matches
    code.chars.each do |char|
      if master_code.include?(char)
        num_of_whites += 1
        remove_first_char(char, master_code)
      end
    end
    num_of_whites
  end


  def remove_first_char(char, word)
    index = word.chars.find_index(char)
    chars = word.chars
    chars.delete_at(index)
    word = chars.join('')
  end

  def remove_black_matches
    master_code = @master_code
    @code.chars.each_with_index do |char, index|
      remove_first_char(char, master_code) if master_code.include?(char) && master_code[index] == char
    end
    master_code
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
