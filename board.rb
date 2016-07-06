
# game should have a board and pass things to board that board needs to 
# run

# store an instance of Board in Game somewhere (initialize method?)

# expand feedback into multiple method calls and move it to game

# make more methods accept parameters

class Board


  def initialize

  end

  def generate_code
    #orange, green, red, blue, purple, yellow
    code = []
    code = 4.times {code << COLORS.sample}
    #
  end

  def current_board
    # contains an array of the current placed colored pegs
    # gets passed the player move
    Game.player_guess 
  end

  def feedback
    semi = 0
    correct_moves = 0
    Game.secret_code.each do |item|
      if current_board.include?(item)
        semi += 1
      end
    end
    Game.secret_code.each_with_index do |item1, index1|
      if current_board[index1] == item1
          correct_moves += 1
          semi -= 1
      end
    end
    puts "You have #{semi} almost correct, and #{correct_moves} correct pegs."
  end 


  def render 
    current_board
    feedback
  end


end
