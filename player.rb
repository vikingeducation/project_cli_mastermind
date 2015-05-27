class Player

  def initialize(role, ai, board)

    @role = role
    @ai = ai
    @board = board

  end


  def ai_enter_code
    code = []
    4.times { code << rand(1..6) }
    code
  end


  # generic loop to get player input
  def get_input

    input = []

    loop do
      if @ai
        input = ai_enter_code
      else
        input = gets.strip.split(",").map(&:to_i)
      end

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
    code = get_input
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