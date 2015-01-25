# MASTERMIND #
class Mastermind
  #set up the board

  def initialize
    @turn = 1
  #set up the players
    @board = Board.new
    @player = Player.new
  end

  #Display the rules of Mastermind

  def play
  #Loop
    display_how_to

    #Render the board
    @board.render

    #Ask for and validate the user's input

    #If the game should end, display the message and break
    loop do
      break if is_game_over?


      turn += 1
      @board.update_turn(turn)

    end
    #Otherwise, give feedback on the user's guess
    # and loop again
  end

  def is_game_over?
    check_victory || check_loss
  end

  def check_victory
    @board.matching_code(@turn)
  end

  def check_loss
    (turn == 12) && !check_victory
  end


  def display_how_to
    puts "Welcome to mastermind!"
    puts "In this game, you have 12 turns to guess the"
    puts "codemaker's code. If all 4 of your pegs matches"
    puts "the code with the correct position and color,"
    puts "you win!"
    puts "To help you, 4 helper pegs may be"
    puts "placed on the board. A white peg means you have"
    puts "a peg with the correct color. A black peg means"
    puts "you have a peg with the correct color AND position"
    puts "\nHave fun!\n"
  end
end


#  BOARD #

class Board
  #Create the game board
  def initialize (turn)
    @board = Array.new(12){Array.new(8)}
    @code = []
    @possible_colors = ["R", "O", "Y", "G", "B", "P"]
    @peg_helpers = ["W", "B"]
    @turn = turn
  end

  #Generate the code
  def generate_code
    4.times do
      @code.push(@possible_colors.sample)
    end
  end

  def ready_empty_board
    12.times do |rows|
      8.times do |columns|
        @board[rows][columns] = "-"
      end
    end
  end

  #Add the piece
  def add_pieces

  end

  #Generate helper peices
  def helper_pieces

  end

  #Correct colors only
  def correct_colors

  end

  #Correct colors + position
  def correct_all
    #compare iteration

  end

  def matching_code turn
    @board[turn-1] == @code

  end

  def update_turn=(turn)
    @turn = turn
  end

end


# PLAYER #

class Player
  def initialize (board)
    @board = board
  end
  def get_user_input
  #Get the user's input
  print "Enter your move in the form [A,B,C,D]: "

  end

  def get_user_entry
    @user_entry =  get.chomp.split

  end

  #Pass it to the board

end