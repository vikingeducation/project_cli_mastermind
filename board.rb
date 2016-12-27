#require './string'
#require './player'
#require './human'
#require './computer'

class Board
  attr_accessor :decoding_board, :feedback, :current_code, :current_codemaker

  def initialize
    @decoding_board = Array.new(12) {Array.new(4, "\u25CB")}
    @feedback = Array.new(12) {Array.new(4, "\u25AB")}
    @current_code = nil # array
    @current_codemaker = nil
  end

  def render_board
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts 'Decoding Board  |  Feedback'
    puts '==========================='
    puts "#{''.ljust(5)}1 2 3 4"
    @decoding_board.each_with_index do |row, guess|
      print "#{"#{guess+1}".ljust(3)}[ "
      row.each do |code_peg|
        print code_peg.ljust(2)
      end
      print "#{']'.ljust(3)}#{'|'.ljust(3)}"
      @feedback[guess].each do |key_peg|
        print key_peg.ljust(2)
      end
      puts
    end
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  end

  def update_board!(guess_array, guess_number)
    # update decoding_board
    guess_array.each_with_index do |code_peg, position|
      @decoding_board[guess_number-1][position] = "#{render_code_peg(code_peg)} "
    end

    # update feedback
    red_key_ct = 0
    guess_array.each_with_index do |code_peg, position|
      red_key_ct += 1 if @current_code[position] == code_peg
    end 
    intersection_with_dup = (guess_array & @current_code).flat_map do |code_peg|
      [code_peg] * [guess_array.count(code_peg), @current_code.count(code_peg)].min 
    end
    gray_key_ct = intersection_with_dup.size - red_key_ct
    
    feedback = ["\u25AA ".red]* red_key_ct + ["\u25AA ".gray] * gray_key_ct
    feedback.each_with_index do |key_peg, index|
      @feedback[guess_number-1][index] = key_peg
    end

    {red: red_key_ct, gray: gray_key_ct} # return feedback hash 
  end

  def render_code
    output = '[ '
    @current_code.each { |code_peg_color| output += "#{render_code_peg(code_peg_color)} "}
    output += ']'
    puts "#{@current_codemaker.name}'s code: #{output}"
  end

  private

  def render_code_peg(code_peg_color)
    peg = "\u25CF"
    case code_peg_color
    when 'r'
      peg.red
    when 'g'
      peg.green
    when 'y'
      peg.yellow
    when 'b'
      peg.blue
    when 'm'
      peg.magenta
    when 'c'
      peg.cyan
    end
  end
end






