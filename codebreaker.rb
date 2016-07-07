#codebreaker.rb
require_relative 'parser'

class CodeBreaker < Player
  
  def initialize(name)  
    super(name)
  end

  def make_guess
    puts "Please enter your four choices (seperated by commas)"
    puts "(Four possible choices could be a, e, i, o, u, y)"
    response = gets

    if Parser.correct_input?(response)
      Parser.make_code(response)
    else
      make_guess
    end
  end
  
end
