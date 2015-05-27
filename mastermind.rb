require "./board.rb"
require "./player.rb"


class Mastermind

  def initialize
    #welcome player
    puts "Welcome!"
    #create new board
    @board = Board.new
    #set up players
    ai_options = get_ai_options
    @codemaker = Player.new("codemaker", ai_options[0], @board)
    @codebreaker = Player.new("codebreaker", ai_options[1], @board)
  end


  def get_ai_options
    maker_ai, breaker_ai = false, false
    puts "Turn AI on for the Codemaker? (y/n)"
    maker_ai = true if gets.chomp.downcase == "y"
    puts "Turn AI on for the Codebreaker? (y/n)"
    breaker_ai = true if gets.chomp.downcase == "y"
    [maker_ai, breaker_ai]
  end


  def play
    system("clear")
    @codemaker.input_prompt("codemaker")

    #turn loop
    system("clear")
    12.times do |turn_number|
      puts "Turn ##{turn_number+1}"
      @codebreaker.input_prompt("codebreaker")

      @board.render
    end

    puts "Good try, but you failed to break the code!"
    @board.display_solution
  end


end

game = Mastermind.new
game.play