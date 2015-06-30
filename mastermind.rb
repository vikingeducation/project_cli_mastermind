# Set up the game [mastermind]
  # Create a game board [board]
  # Create two players: Code-maker and code-breaker [player]
  # Code maker makes code #(solution) [board]
# Start the game loop (12 tries) [mastermind]
  # Render the board [board]
  # Take code-breaker guess [player]
  # Validate guess (valid input) [player]
  # Compare guess to solution [ask board]
    #If guess is correct -
      #end game [mastermind]
    #Else -
      #show information on guess [board]
        # Number of correct colored pegs in correct position [board]
        # Correct colored pegs in wrong position [board]
#end game [mastermind]
  #show actual solution [board]
  #replay [mastermind]

class Mastermind #Game flow

  def initialize
    @board = Board.new
    @code_breaker = Player.new
    @code_maker = Computer.new
  end

  def play
    @tries = 12
    @board.render
    while @tries >= 0
      #player guess
      #board compares guess to solution
      if @guess == @solution
        win_game
        break
      else
        @tries -=1
        @board.render #colored pegs hints
      end
    end
    lose_game
  end

  def win_game
    puts "Congratulations! Your code was correct!"
    play_again?
  end

  def lose_game
    puts "Sorry! The solutions was:"
    @solution.display
  end

  def play_again?
    is_valid = false
    until is_valid
      print "Do you want to play again? (Y/N): "
      input = gets.chomp.downcase
      is_valid = is_true_or_false?(input)
      puts "Try 'y' or 'n'" unless is_valid
    end
    return input == "y"
  end


  def is_true_or_false?(input)
    ["y", "n"].include?(input)
  end

end

class Board #Game logic

  def initialize
    @board = 12.times {|row| row = []}
  end


end

class Player #Inputs

  def initialize

  end

end

class Computer #as code maker

  def initialize

  end

  def make_code
    CODE_COLORS = [:orange, :red, :yellow, :purple, :green, :blue]
    #generate random code of 6 colors
    solution = colors.sample(4)
  end

end

