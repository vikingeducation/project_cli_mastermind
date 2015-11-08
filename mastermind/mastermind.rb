class Mastermind

  def initialize(guesses = 3, player_name = 'Ruby Tuby', allow_dups = false)
    # @board = Board.new(guesses)
    # @codemaker = Codemaker.new(allow_dups)
    # @codebreaker = Codebreaker.new(player_name, @board)

    start
  end

  def start
    puts "************************************"
    puts "***    Welcome to Mastermind!    ***"
    puts "************************************\n\n"
    puts "INSTRUCTIONS:"
    puts "Enter your color guess using letters separated by a comma.\n\n"
    puts "COLOR CODE:"
    puts "r = red, b = blue, g = green, y = yellow, p = purple, o = orange\n\n"
    puts "For example:\n Enter move > r,b,g,y\n\nEnter 'q' to quit. \n\nCurrent Board:"

    # kick off the moves
    # play
  end

  def play
  end
end

game = Mastermind.new