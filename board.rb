class Board

  def initialize
    @board = []
  end

  def render(code)
    puts
    p @board
    puts
    print "Secret Code: "
    p code
    puts
  end

  def add_guess(guess)
    @board << guess
  end

  def get_feedback(guess, secret_code)
    temp_code = secret_code.dup
    temp_code = exact_color_count(guess, temp_code) #count num nil
    close = close_color_count(guess, temp_code)
    puts '#' * 10
    puts "You have #{close} correct colors in the wrong spot and #{temp_code.count nil} in the correct spot."
  end

  def exact_color_count(guess, secret_code)
    # guess.select.with_index do |peg, location|
    #   peg == secret_code[location]
    # end.length
    secret_code.map.with_index do |peg, location|
      if peg == guess[location]
        nil
      else
        peg
      end
    end
  end

  def close_color_count(guess, secret_code)
    counter = 0
    guess.each { |peg| counter += 1 if secret_code.include? peg }
    counter

    # counter = 0
    # temp_code = secret_code.dup
    # temp_code.reverse_each do |peg|
    #   if guess.include? peg
    #     counter += 1
    #     temp_code[]
    #   else
    #   end
    # end
    # counter
  end

end
