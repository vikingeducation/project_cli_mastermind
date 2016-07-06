class Board

  def initialize
    @board = []
  end

  def render
    puts
    p @board.last
    puts
    puts
  end

  def add_guess(guess)
    @board << guess
  end

  def get_feedback(guess, secret_code)
    temp_code = secret_code.dup
    temp_code = adjust_temp_code_exact(guess, temp_code)

    close = close_color_count(guess, temp_code)
    exact = exact_color_count(temp_code)
    puts '#' * 10
    puts "You have #{close} correct colors in the wrong spot and #{exact} in the correct spot."
  end

  def adjust_temp_code_exact(guess, temp_code)

    temp_code.map.with_index do |peg, location|

      if peg == guess[location]
        nil
      else
        peg
      end
    end
  end

  def exact_color_count(temp_code)
    temp_code.count nil
  end

  def close_color_count(guess, temp_code)
    counter = 0

    guess.each do |peg|
      if temp_code.include?(peg)
        counter += 1
        i = temp_code.index(peg)
        temp_code[i] = 0
      end
    end
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
