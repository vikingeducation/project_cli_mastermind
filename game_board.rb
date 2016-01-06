#keeps track of game state and can render states
require './peg/key_peg.rb' 
require './peg/code_peg.rb' 

class GameBoard
  attr_accessor :answer_key
  #each row has 4 big codepegs 4 small keypegs
  def initialize
    @board = Array.new(12) { Array.new(8,"o") }
    @answer_key = Array.new(4, "o")
  end

  #prints board
  def render
    row_index = 1
    @board.each do |row|
      print "#{row_index}"
      row_index += 1
      row.each do |col|
        print "#{col} "
      end
      puts
    end
    puts
  end

  def get_color_pegs
    code_peg_colors = CodePeg::COLORS
    print "Enter your 4 colors from #{code_peg_colors} : "
    user_input = gets.chomp.split(" ")
    
    until user_input.length == 4 &&\
          user_input.all? { |item| code_peg_colors.include?(item) } 
      print "Enter your 4 colors from #{code_peg_colors} : "
      user_input = gets.chomp.split(" ")
    end  
    user_input

  end

  def set_answer_key(code_key)
    self.answer_key[0] = code_key[0]
    self.answer_key[1] = code_key[1]
    self.answer_key[2] = code_key[2]
    self.answer_key[3] = code_key[3]
  end

end
