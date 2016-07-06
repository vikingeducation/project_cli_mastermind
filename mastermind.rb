COLORS = [
  "red",
  "blue",
]

[ 4 2 4 1 ]
COLORS[peg]

class Mastermind

  def initialize
    # assign codebreaker -> Player.create_player
    @codebreaker = Player.create_player("the Codebreaker")
    # assign codemaker -> Player.create_player
    @codemaker = Player.create_player("the Codemaker")
    # create new board with setup from codebreaker
    @board = Board.new(@codebreaker)
  end

  def play

    loop do 
    # render board [board]
      @board.render
    # check for game over [Board]
      break if @board.game_over?
    # allow player to guess or quit and send to Board[Player]
      @board.move(@codebreaker.get_move(@board))
    end

  end


  # end game
end
  
class Board
  # COLORS
  @game_turns = 12

  attr_reader :pegs :colors :moves

  def initialize(player)
    # number of turns
    @player_turns = 0
    # array of moves
    @moves = []
    # get number of pegs [ask player]
    @pegs = player.get_pegs
    # get number of colors
    @colors = player.get_colors
  end

  # render
    # start as number_of_turns lines
    # array of pegs with color
    # go through each move so far and print that line, plus feedback for that line

  #  move
    # add move to board

  # give feedback
    # look at current turn
      # count number of correct, half-correct, and wrong
    # return

  #check for game over
    # did they win?
    # are the moves over?

  # win?

  # moves left?

end


class Player
  def initialize(name)
    @name = name
  end 

  def get_move(board)
    puts "Let's get your next move."
    input_code(board)
  end

  def make_answer(board)
    puts "Let's set up the secret answer."
    input_code(board)
  end



  def self.create_player(position)
    input = ""

    until %w[ human h computer c].include(input)
      puts "Will #{position} be a computer or a human?"
      input = gets.chomp.downcase
    end

    if %w[ human h ].include(input)
      Human.new(position)
    else
      Computer.new(position)
    end
  end

end

1: [ R G R B R R R ]  Correct: 3 Wrong place: 1 Wrong: 2
2: [ R G R B 5 6 7 ]
3: [ R G R B 5 6 7 ]  

Current: [ R G R B 5 6 7 ]
What do you want in position 1?
(R=Red B=Blue ... 1 = Quit 2 = Render board) ? 
Current: [ R G R B 5 6 7 ]
What do you want in position 2?
(R=Red B=Blue...) ? 


class Human < Player
  #input_code
    #ask for input
    #check for format
  def input_code(board)
    
    current_turn = (1..board.pegs).to_a
    board.pegs.times do |peg|
      print_current_turn(current_turn)
      input = receive_input
      current_turn[peg] = input
    end
    current_turn

    
  end

  def receive_input


  end

  def print_current_turn
    print "Current turn: " 
    print current_turn
  end

  def get_pegs
    
    pegs = 0
    until (4..6).include?(pegs)
      puts "How many pegs do you want to play with? Choose 4-6."
      pegs = gets.chomp.to_i
    end
    pegs

  end

  def get_colors

    colors = 0
    until (2..8).include?(colors)
      puts "How many colors do you want to play with? Choose 2-8."
      colors = gets.chomp.to_i
    end
    colors

  end

end
   

class Computer < Player
  #input_code
    #generate array of colors

  def get_pegs
    pegs = (4..6).sample
    puts "You're playing with #{pegs} pegs."
    pegs
  end

  def get_colors
    colors = (2..8).sample
    puts "You're playing with #{colors} colors."
    colors
  end
end



