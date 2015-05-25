class Mastermind

  def initialize

    load "board.rb"
    load "player.rb"
    #welcome player
    puts "Welcome!"
    #create new board
    @board = Board.new
    #set up players
    @codemaker = CodeMaker.new("codemaker", @board)
    @codebreaker = CodeBreaker.new("codebreaker", @board)

  end


  def play
    #prompt codemaker for code
    @codemaker.get_code

    #turn loop
    3.times do |turn_number|
      puts "Turn ##{turn_number+1}"
      #prompt codebreaker for guess
      @codebreaker.get_guess
      #check guess vs board
      #display board feedback

      #render board
      @board.render
    end

    puts "Good try, but you failed to break the code!  The actual solution was:"
    @board.display_solution
  end


end

game = Mastermind.new
game.play