# Display the Board
class Board
  attr_accessor :board

# Show the board at the beginning of the game
  def initialize
    @board = []
  end

  def render(feedback)
    # display the current state of the board
    @board.each do |x|
      x.each do |y|
        print " #{y} |"
      end
      puts ""
      puts "-----------------"
    end
    puts "#{feedback[0]} exact peg(s) are the correct colour and in the correct position"
    puts "#{feedback[1]} close peg(s) are the correct colour but in the wrong position"
  end

  def add_guess(guess)
     @board.push(guess)
  end
end