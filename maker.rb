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

  def feedback(guess, code)
    feedback_arr = []



    # copy = guess
    # code_copy = code
    # copy.each_with_index do |ele, i|
    #   if code_copy[i] == copy[i]
    #     feedback_arr.push("r")
    #     # copy.delete_at(i)
    #     copy[i] = nil
    #     code_copy[i] = "-"
    #   end
    # end
    # copy.each_with_index do |ele, i|
    #   if code_copy.include?(ele)
    #     feedback_arr.push "w"
    #     code_copy[code_copy.find_index(ele)] = "-"
    #   end
    # end
    # feedback_arr
  end

  # def exact_match_at(guess)
  #   arr_exact = []
  #   guess.each_with_index do |ele, i|
  #     arr_exact << i if ele == code[i]
  #   end
  #   arr_exact
  # end

  # def partial_match_at(guess)
  #   arr_partial = []
  #   guess.delete_at(exact_match_at(guess))
  #   match_hash = Hash.new(0)
  #   code_hash = Hash.new(0)
  #   guess.each {|x| guess_hash[x] += 1}
  #   code.each {|x| code_hash[x] += 1}
  #   guess_hash.each do |key, value|
  #     guess_hash[key] = code_hash[]
  #   end
  #   guess.sort
  #   guess.each_with_index do |ele, i|

  # end

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
