require_relative 'board.rb'

class Player

  def initialize(name)
    @name = name
    @turn = 12
    @board = Board.new
  end


  def guess
    #player makes guesses
  end

end

class Human < Player
  def create_winning_board
    winning_board = []
    index = 1
    until winning_board.length == @board.pegs do
      puts "Please enter your peg ##{index} color:"
      peg_color = gets.chomp.upcase
      if !Board::COLORS.include?(peg_color)
        #bad
        puts "Invalid color."
        next
      else
        #good!
        winning_board << peg_color
        index += 1
      end
    end
    winning_board
  end
end

class Computer < Player 

  #use 4 random pegs from board.colors
  def create_winning_board
    winning_board = []
    @board.pegs.times do 
      winning_board << Board::COLORS.sample
    end
  end

end

hum = Human.new("Name")
puts hum.create_winning_board
