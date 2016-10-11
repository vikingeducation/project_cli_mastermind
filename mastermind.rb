class Mastermind

  def initialize
    @board = Board.new
    @player = Player.new
    @code = Code.new
  end

  def instruction_display
    puts "About the game"
    puts "The computer has selected a secret combination of 4 colored pegs /
          and you have to guess that combination in 12 tries to win."
    puts
    puts "How to play . . ."
    puts "To create your guess you will be asked to choose combination of 4."
    puts "Each time you submit a guess the machine will use score pegs to let /
          you know how close that guess is."
    puts "For each guess a black score peg indicates that one of your pegs is /
          the right color in the right position."
    puts "A white score peg indicates that one of your pegs is the right color /
          in the wrong position."
  end

  def welcome_display
    puts "Hello and Welcome to Mastermind game"
    puts "Please type i to remind the rules of the game or s to start the game"
  end

  def start_or_rules
    loop do
      s_or_i = gets.chomp
      if s_or_i == "i"
        instruction_display
        break
      elsif s_or_i == "s"
        break
      end
    end
  end

  def play
    welcome_display
    start_or_rules
    turn = 1
    while turn <= 12
      @board.render
      @player.get_combination
      break if is_code_guessed?
       n += 1
    end
    @board.render
    loosing
    @code.render
  end

  def is_code_guessed?
    if @player.get_combination == @code.get_combination
      puts "Congratulations!!! You have guessed the secret colour code."
      true
    else
      false
    end
  end

  def loosing
    puts "You didn't guess the right combination in 12 turns."
    puts "The right combination you didn't guess is #{@code.render}"
  end

end

class Board
  COLOURS = ["R","B","G","P","Y","O"]
  PEGS = ["w","b"]

  def initialize(turn)
    @turn = turn
    @board = {0 => [[nil,nil,nil,nil],[nil,nil,nil,nil]]}
  end

  #initialize the board
    #setup blank data structure
      #colours data
      #feedback data
      #Hash with 2D Array ie. {1 => [[R,B,G,Y], [w,w,e,b]]}
#
  #store guesses

  def feedback_of_guessing
    feedback = []

    #feedback provider
    #provide feedback with code and key pegs
  end

  #render
    #loop through data structure
      #Display existing guesses if any, else blank

  #checks winning condition 
    #if colour 

  #provides feedback about colours only
    #loop
    #check if the remaining colours from provides feedback about colours and positions
      # if matches the one from the original code
        # generate white peg

  #provides feedback about colours and positions
    #loop
    # if colour macthes the original colour
      # if colour matches the position
        #generate black peg
        #generate array of ramainig not matching this criteria

RED
BLUE
GREEN
PURPLE
YELLOW
ORANGE
end

class Code
  COLOURS = ["R","B","G","P","Y","O"]

  def initialize
    @combination = COLOURS.sample(4)
  end

  def render
    puts "#{@combination[0]} - #{@combination[1]} - #{@combination[2]} - #{@combination[3]}"
  end
end

class Player
  COLOURS = ["R","B","G","P","Y","O"]

  def initialize(board)
    @board
  end

  def ask_for_combination
    puts "Take a guess of the combination of the following colours:"
    puts "RED BLUE GREEN PURPLE YELLOW ORANGE"
    puts "Please make a guess by typing first letter of colours in the following pattern:"
    puts "R-G-B-B"
    puts
    gets.strip.upcase.split("-")
  end

  def validate_combination(combination)
    combination.each do |colour|
      if colour.incldue? (COLOURS)
        true
      else
        puts "You have typed incorrect pattern. Please provide correct colour combination guess."
      end
    end
  end

  def get_combination
    loop do
      guess = ask_for_combination
      if validate_combination(guess)
        if @board.add_guess(combination)
          break
        end
      end
    end
  end

end
