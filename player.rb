class Player
  attr_accessor :role

  def initialize(role, board)

    @role = role
    @board = board

  end




  # generic loop to get player input
  def get_input

    input = []

    loop do
      input = gets.strip.split(",").map(&:to_i)
      if is_valid?(input)
        break
      else
        puts "Entry was invalid - please try again."
      end
    end

    input

  end




  # to check if a code or guess is formatted properly
  def is_valid?(submitted)

    if  submitted.is_a?(Array) &&   # guess is an array
        submitted.size == 4 &&      # guess array is size 4
        submitted.max <= 6 &&       # each value is between 1 and 6
        submitted.min >= 1
      true
    else
      false
    end

  end


end




class CodeMaker < Player

  def get_code
    puts "Codemaker, submit your secret code:"

    # for human CodeMaker
    #code = get_input

    # for "AI" CodeMaker
    code = []
    4.times { code << rand(1..6) }

### for testing only!!!
    print code.to_s + "\n"
###

    @board.add_secret_code(code)
  end

end




class CodeBreaker < Player

  def get_guess
    puts "Codebreaker, submit your guess:"
    guess = get_input
    @board.process_guess(guess)
  end

end