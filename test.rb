  def feedback(code, guessed_code)
    black_pegs, white_pegs = 0
    temp_code = code
    4.times.do |position|
      if temp_code[position] == guessed_code[position]
        back_pegs += 1
        temp_code[position] = "X" # this is to prevent this digit from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
      else 
        4.times.do |temp_code_position|
          if temp_code[temp_code_position] == guessed_code[position]
            white_pegs += 1
            temp_code[temp_code_position] = "X" # this is to prevent this digit from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
          end
        end
      end
    end
    return guessed_code, black_pegs, white_pegs
  end

code = ["1", "2", "3", "4"]
guessed_code = ["1", "3", "4", "4"]
feedback(code, guessed_code)
