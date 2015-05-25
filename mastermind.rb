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
    12.times do |turn_number|
      #prompt codebreaker for guess
      @codebreaker.get_guess
      #check guess vs board
      #display board feedback

      #render board
      @board.render
    end
  end


end

game = Mastermind.new
game.play