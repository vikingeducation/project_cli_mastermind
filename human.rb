class Human < Player


  def create_board
    human_board = []
    index = 1
    until human_board.length == @board.pegs do
      puts "Please enter your peg ##{index} color:"
      peg_color = gets.chomp.upcase
      if !Board::COLORS.include?(peg_color)
        #bad
        puts "Invalid color."
        next
      else
        #good!
        human_board << peg_color
        index += 1
      end
    end
    human_board
  end





end








# hum = Human.new("Name")
# puts hum.create_winning_board