require_relative 'game'

PEGS = %w(R G B Y O T).freeze

class CodeMaker
  attr_reader :code

  def initialize
    @code = []
  end

  def prompt_for_code
    puts 'Enter your code. Select four of the following: R, B, G, O, Y, T'
  end

  def create_code(who_is_codemaker)
    if who_is_codemaker == 1
      4.times { @code << PEGS.sample }
    else
      prompt_for_code
      user_input = gets.chomp.upcase.split('')
      user_input.each { |peg| self.code << peg } 
    end
    code
  end
end