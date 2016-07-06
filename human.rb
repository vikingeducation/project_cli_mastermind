# 1: [ R G R B R R R ]  Correct: 3 Wrong place: 1 Wrong: 2
# 2: [ R G R B 5 6 7 ]
# 3: [ R G R B 5 6 7 ]  

# Current: [ R G R B 5 6 7 ]
# What do you want in position 5?
# (R=Red B=Blue ... 1 = Quit 2 = Render board) ? G

# Current: [ R G R B G 6 7 ]
# What do you want in position 6?
# (R=Red B=Blue ...)
# example ? 

# What colors do want for the pegs?
# separate pegs by spaces
# r = Red, g = Green
# r g r b r r

class Human < Player
  #input_code
    #ask for input
    #check for format
  def input_code(board)
    begin
      print_turn_prompt
      input = gets.chomp.split
    end until parse(input, board)
  end

  def parse(input, board)
    input.all? { |item| board.colors.include?(item.downcase)} &&
     input.length == board.pegs
  end

  def print_turn_prompt
    puts "What colors do you want for the pegs?"
    puts "Separate by spaces."
    puts
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