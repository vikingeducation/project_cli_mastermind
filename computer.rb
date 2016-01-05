class Computer < Player 

  #use 4 random pegs from board.colors
  def create_board
    winning_board = []
    @board.pegs.times do 
      winning_board << Board::COLORS.sample
    end
    winning_board
  end

end