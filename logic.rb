module Logic

  def check_victory( input, turn )
    if code == input
      victory
    elsif turn == 12
      defeat
    end
  end

  def victory
    puts "\n You find the code ! You Win !\n"
    puts " The code was #{code} !\n"
    exit
  end

  def defeat
    puts "\nThe code was #{code} !"
    puts "\n Well Tried !\n"
  end


  def compare( input, turn )
    check_victory( input, turn )
    close_or_exact[turn] = {"near" => 0, "exact" => 0}
    code.each do |key, value|
      if input[key] == value
        close_or_exact[turn]["exact"] += 1
      elsif input.values.include?(value)
        close_or_exact[turn]["near"] += 1
      end
    end
  end

end