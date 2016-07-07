require_relative 'player.rb'
# require_relative 'board.rb'
require 'pry'

class Maker < Player
  # attr_reader :name, :code, :board
  attr_reader :name, :code, :board
  # attr_accessor :code, :board

  def initialize
    super
    @name = "Code Maker"
    @code = []
  end

  def set_code
    @code = get_input
  end

  def feedback(guess)
    # binding.pry
    reds = exact_matches(guess)
    whites = partial_matches(guess) - reds
    fb_arr = Array.new(reds, "r") + Array.new(whites, "w")
    (4 - reds - whites).times {fb_arr.push("*")} unless fb_arr.length == 4
    add_feedback_to_board(fb_arr.shuffle)
  end

  # def add_feedback_to_board(arr)
  #   @board[@board.find_index(Array.new(4))] = arr.shuffle
  #   fb_arr
  # end

  def exact_matches(guess)
    exact_matches = 0
    guess.each_with_index do |ele, i|
      exact_matches += 1 if ele == @code[i]
    end
    exact_matches
  end

  def partial_matches(guess)
    copy = code.dup
    partial_matches = 0
    guess.each do |x|
      if copy.include?(x)
        partial_matches += 1
        copy[copy.find_index(x)] = nil
      end
    end
    partial_matches
  end



end

def test

  maker = Maker.new
  maker.code = %w[r r r r]
  guess = %w[r r r r]
  maker.feedback(guess)

  maker.code= %w[b r w r]
  guess = %w[b y r b]
  maker.feedback(guess)

  maker.code= %w[b r w r]
  guess = %w[r b r w]
  maker.feedback(guess)

  maker.code= %w[b r w r]
  guess = %w[b w r r]
  maker.feedback(guess)

  maker.code= %w[b b w y]
  guess = %w[g r o p]
  maker.feedback(guess)
  puts maker.board[0..4]
end

# test
