class Board

  def initialize
    @board = []
  end

  def render
    p @board
  end

  def add_guess(guess)
    @board << guess
    get_feedback(guess, secret_code)
  end

  def get_feedback(guess, secret_code)
    close = close_color_count(guess, secret_code)
    exact = exact_color_count(guess, secret_code)
    puts "You have #{close - exact} correct colors in the wrong spot and #{exact} in the correct spot."
  end

  def close_color_count(guess, secret_code)
    counter = 0
    temp_code = secret_code
    temp_code.reverse_each do |peg|
      if guess.include? peg
        counter += 1
        temp_code.delete peg
      end
    end
    counter
  end

  def exact_color_count(guess, secret_code)
    guess.select.with_index { |peg, location| peg == secret_code[location] }.length
  end

end
