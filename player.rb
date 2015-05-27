class Player
  #attr_accessor :role

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


  def get_maker_code
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


  def get_breaker_code
    puts "Codebreaker, submit your guess:"
    guess = get_input
    @board.process_guess(guess)
  end


  def input_prompt(role)
    if role == "codemaker"
      get_maker_code
    else
      get_breaker_code
    end
  end






  # to check if a code or guess is formatted properly

  def is_valid_length?(submitted)
    # each value is between 1 and 6
    submitted.max <= 6 && submitted.min >= 1
  end


  def is_valid_range?(submitted)
    submitted.size == 4   # guess array is size 4
  end


  def is_valid?(submitted)
    submitted.is_a?(Array) && is_valid_length?(submitted) && is_valid_range?(submitted)
  end

end