# require_relative 'game.rb'

class Logic

  def evaluate_color(winning_board, guess_board)
    #returns how many correct colors
    color_count = 0
    test_winning_board = winning_board.dup
    guess_board.each_with_index do |color, index|
      if test_winning_board.include?(color)
        test_winning_board[index] = "Processed"
        color_count += 1
      end
    end
    color_count
  end

  def evaluate_position(winning_board, guess_board)
    #returns how many correct positions
    position_count = 0
    guess_board.each_with_index do |color, index|
      position_count += 1 if guess_board[index] == winning_board[index]
    end
    position_count
  end



end