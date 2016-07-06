# mastermind
# 4 colors, 4 pegs
# 12 turns to crack code
#   win condition
#   lose condition
# Player class
#   validate format
# Computer class
#   random colors
# Human class
#   input colors
#   guess
# Board class
#   holds the key
#   render board
#   check guesses

require_relative "player"
require_relative "computer"
require_relative "human"
require_relative "board"

class Mastermind

  def initialize
    @board = Board.new
    if opening_message == "B"
      @player1 = Human.new(@board)
      @player2 = Computer.new(@board)
    else
      @player1 = Computer.new(@board)
      @player2 = Human.new(@board)
    end
  end

  def opening_message
    loop do
      puts "Would you like to be Codemaker (M) or Code breaker (B)?"
      choice=gets.chomp
      if validate_choice(choice)
        break
      else
        p "Please enter a valid choice"
      end
    end
  end

  def validate_choice(choice)
    ["B","M"].include?(choice)
  end

  def play
    @player2.input_colors
    until finish?
      @player1.get_guess
      @board.render
    end
    closing_message
  end

  def closing_message
    if win?
      puts "You won!"
    else
      puts "The code was #{@board.key}"
      puts "Better luck next time..."
    end
  end

  def finish?
    win? || lose?
  end

  def win?
    @board.correct?
  end

  def lose?
    @board.guesses >= 12
  end


end

m=Mastermind.new
m.play
