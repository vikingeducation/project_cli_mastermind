class Player

  def ask_for_combination
    gets.chomp.split(" ").map!(&:to_i)
  end


  def good_format? input
    if input.is_a?(Array) && input.size == 4
      return true
    else
      puts "Your combination guess should be in the form  2 3 4 1\n"
    end
  end


  def in_range? input
    if input.all? { |guess| guess.between?(1,6) }
      return true
    else
      puts "Each choice should be in between 1 and 6\n"
    end
  end


  def get_combination
    loop do
      input = ask_for_combination
      if good_format? input
        if in_range? input
          return transform_in_hash input
        end
      end
    end
  end


  def transform_in_hash input
    input_hash = {}
    i = 1
    input.each do |item|
      input_hash[i] = item
      i += 1
    end
    input_hash
  end

end