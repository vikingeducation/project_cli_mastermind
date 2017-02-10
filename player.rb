class Player
  def feedback(code, attempt)
    exact = 0
    total_close = 0
    attempt.each_with_index do |att_color, att_index|
      close = false
      code.each_with_index do |cod_color, cod_index|
        if (att_color == cod_color) && (att_index == cod_index)
          exact += 1
          close = false
          break
        elsif code.include?(att_color)
          close = true
        end
      end
      if close
        total_close +=1
      end
    end
    puts "You got #{exact} Exact and #{total_close} Close!"
    return exact
  end
end
