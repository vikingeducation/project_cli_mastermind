require "./board.rb"
require "./player.rb"


class Mastermind

  def initialize
    #welcome player
    puts "Welcome!"
    #create new board
    @board = Board.new
    #set up players
    @codemaker = Player.new("codemaker", @board)
    @codebreaker = Player.new("codebreaker", @board)
  end


  def play
    #prompt codemaker for code
    @codemaker.input_prompt("codemaker")

    #turn loop
    3.times do |turn_number|
      puts "Turn ##{turn_number+1}"
      #prompt codebreaker for guess
      @codebreaker.input_prompt("codebreaker")
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