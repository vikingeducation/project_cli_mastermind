require_relative 'player.rb'

class Maker < Player
  attr_reader :fb_board, :name
  attr_accessor :code

  def initialize
    @fb_board = Board.new
    @name = "Code Maker"
    @code = []
  end

  def set_code
    @code = get_input
  end

  def feedback(guess)
    reds = exact_match_at(guess)
    whites = partial_match_at(guess) - reds
    fb_arr = []
    reds.times {fb_arr << "r"}
    whites.times {fb_arr << "w"}

    @fb_board[@fb_board.find_index(Array.new(4))] = fb_arr
    fb_arr
  end



  def exact_match_at(guess)
    arr_exact = []
    guess.each_with_index do |ele, i|
      arr_exact << i if ele == code[i]
    end
    arr_exact.length
  end

  def partial_match_at(guess)
    copy = code
    count = 0
    guess.each do |x|
      if copy.include?(x)
        count += 1
        copy[copy.find_index(x)] = "-"
      end
    end
    count
  end



end

def test

  maker = Maker.new
  code= %w[r r r r]
  guess = %w[r r r r]
  p maker.feedback(guess, code)

  code= %w[b r w r]
  guess = %w[b y r b]
  p maker.feedback(guess, code)

  code= %w[b r w r]
  guess = %w[r b r w]
  p maker.feedback(guess, code)

  code= %w[b r w r]
  guess = %w[b w r r]
  p maker.feedback(guess, code)

  code= %w[b b w y]
  guess = %w[g r o p]
  p maker.feedback(guess, code)


end

# test
