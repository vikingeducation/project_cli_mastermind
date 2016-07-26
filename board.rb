# Board class is here
class Board

  def initialize
    @array = Array.new(12){ Array.new(4, 0) }
  end

  def feedback code, guess
    result = {}
    result[:black] = exact_guess code, guess
    result[:white] = close_guess code, guess
    puts "There are/is #{result[:black]} exact guess and #{result[:white]} close result"
  end

  def display guess, i
    modify_array guess, i
    @array.each do |row|
      row.each do |element|
        print element.to_s.center(5)
      end
      puts ""
    end
  end


  # Attention! Methods below are all private
  private

  def modify_array guess, i
    4.times do |index|
      @array[i][index] = guess[index]
    end
  end

  def exact_guess code, guess
    result = 0
    4.times do |i|
      result += 1 if guess[i] == code[i]
    end
    result
  end

  def close_guess code, guess
    result = 0
    code_index_mark = []
    guess_index_mark = []
    4.times do |i|
      if guess[i] == code[i]
        code_index_mark << i
        guess_index_mark << i
      end
    end
    code.each_with_index do |code_num, code_index|
      guess.each_with_index do |guess_num, guess_index|
        if (code_num == guess_num) && (!code_index_mark.include? code_index) && (!guess_index_mark.include? guess_index)
          result += 1
          code_index_mark << code_index
          guess_index_mark << guess_index
        end
      end
    end
    result
  end

end
