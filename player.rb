class Player
  attr_accessor :role

  def initialize(role, board)
    @role = role
    @board = board
  end



end


class CodeMaker < Player

  def get_code
    puts "Codemaker, submit your secret code:"
    code = []
    4.times { code << rand(1..6) }
    @board.add_secret_code(code)
  end

end


class CodeBreaker < Player

  def get_guess
    puts "Codebreaker, submit your guess:"
    guess = gets.strip.split(",").map(&:to_i)
    #test if valid
    #send to board
    @board.process_guess(guess)
  end

end