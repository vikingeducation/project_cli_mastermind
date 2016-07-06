class Human < Player
  def input_code(board)
    begin
      print_turn_prompt(board)
      input = gets.chomp.split
    end until parse(input, board)
    input
  end

  def parse(input, board)
    input.all? { |item| board.colors.include?(item.downcase)} &&
     input.length == board.pegs
  end

  def print_turn_prompt(board)
    puts "What colors do you want for the pegs?"
    puts "Please enter #{board.pegs} pegs separated by spaces."
    board.colors.each do |color|
      print color + " = " + $COLORS[color] + ", "
    end
    print "\n"
  end

  def get_pegs
    
    pegs = 0
    until (4..6).include?(pegs)
      puts "How many pegs do you want to play with? Choose 4-6."
      pegs = gets.chomp.to_i
    end
    pegs

  end

  def get_colors

    colors = 0
    until (2..8).include?(colors)
      puts "How many colors do you want to play with? Choose 2-8."
      colors = gets.chomp.to_i
    end
    colors

  end

end