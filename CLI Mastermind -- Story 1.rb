# CLI Mastermind -- Story 1

# DRAFT 1
# -------

# Note. Could write as "Module Mastermind" containing "Class Game"
#       (replacing "Class Mastermind") and all other classes, in 
#       order to encapsulate the whole game. 


class Mastermind

  # initialize (set up game)
  def initialize
    # set up board
    @board = Board.new

    # set up players (Note. I am now thinking towards putting these into two separate classes, possibly with Player as parent.)
    @codemaker = Player.new("codemaker")
    @codebreaker = Player.new("codebreaker")

    
  end

# welcome message and rules
  def welcome
    puts "\n"
    puts "Welcome to Mastermind! Are you a champion?\n"
    puts '''
        RULES: The codemaker is creating a 4-digit code. Each digit is in the range 1 - 6. For example, "1234". 
        You, the codebreaker, have 12 guesses to crack the code.
        After that you lose. 

        After you enter your guess you will get this feedback:
        1. the guessed code
        2. number of black pegs
        3. number of white pegs

        Each black (or "exact") peg means you have guessed the right color and position of ONE of the code digits.
        Each white (or "close") peg means you have guessed the right color of ONE of the code digits but it is in ANOTHER position.

        Let\'s begin! '''
    end    
        

  # play
  def play
    # create code (set of four pegs/colors to be guessed by codebreaker)
    code = @codemaker.create_code
          # I don't need @player because @codemaker is an instance of Player - right?

    guess_attempts = 0
    loop do                # infinite loop
      guess_attempts += 1
      guessed_code = @codebreaker.guess_code
      @board.feedback_and_display(code, guessed_code)

      if @board.guess_correct?
        victory
        break
      elsif max_guess_attempts?
        defeat
        break
      end
    end
  end

  def victory
    puts "\nvictory! You have cracked the code: #{code.join} \n"
  end

  def max_guess_attempts?
    if guess_attempts > 12
  end 

  def defeat
    puts "\nsorry! You have exceeded 12 guesses. Game lost. Better luck next time!"
    puts "codemaker's code was #{code.join} \n"
  end

end   # end class Mastermind


Class Board

  attr_accessor :code :guessed_code     # necessary?

  # initialize board
  def initialize(code, guessed_code)
    @code = code
    @guessed_code = guessed_code
  end
  
  # I do not see the need to initialize pegs and colors. They are contained in "code" and "guessed_code" arrays. That is "position of peg" = position in array; and "color" array item value,  represented by range 1 thru 6.
 
# feedback and display response (umbrella method)
  def feedback_and_display(code, guessed_code)
    guessed_code, black_pegs, white_pegs = feedback(code, guessed_code)
    display_feedback(guessed_code, black_pegs, white_pegs)

      # note: I could make a short cut:
        # "display_feedback(guessed_code, black_pegs, white_pegs) = feedback(code, guessed_code)" 
      # however, I think that is a risk because the reader may not easily understand what is going on.
  end

  def feedback(code, guessed_code)
    black_pegs, white_pegs = 0
    temp_code = code
    code.each do |pos_code|
      if temp_code[pos_code] = guessed_code[pos_code]
        back_pegs += 1
        temp_code[pos_code] = "X" # this is to prevent this digit from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
      else 
        guessed_code.each do |pos_guessed_code|
          if temp_code[pos_code] = guessed_code[pos_guessed_code]
            white_pegs += 1
            temp_code[pos_code] = "X" # this is to prevent this digit from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
          end
        end
      end
    end
    guessed_code, black_pegs, white_pegs
  end

  def display_feedback(guessed_code, black_pegs, white_pegs)
    puts "\nFeedback:"
    print "guessed code: #{guessed_code.join} ... "
    print "black pegs: #{black_pegs} ... "
    puts "white pegs: #{white_pegs}"
  end

  def guess_correct?
    if black_pegs == 4
    end
  end

end   # end class Board


Class Player

  attr_accessor :name :code :guessed_code #do I need :code and :guessed_code - as not imported into class but exported out? So far :name is not used so not necessary now

  # initialize codemaker
  def initialize(name)
    @name = name
    ....

  end

  # codemaker creates code (to be guessed)
  def create_code
    #random_generation (could be alternatively by human input)    code = []
    4.times do
      code << rand(1..6).to_s
    end
    code # to return to Mastermind
  end

  ...


  # codebreaker guesses code
  def guess_code
    # enter manually (later on option through AI algorithm) 
    guessed_code = []
#    4.times do |num|
      loop do    # input all codes at the same  ..................
        print "Enter guess: 4 digits (each 1, 2, 3, 4, 5 or 6 - eg, 1234): "
        digits = gets.chomp
        break if digits.include?("1111".."6666")
        puts "Incorrect code - try again"
      end
    end
    guessed_code = digits.split() 
  end

...

end  # end class Player

# Erik says not to have AnalyzeGuess class (cf Kit recommended it)

# Class AnalyzeGuess
  
#  def initialize(code, guessed_code)
#    @code = code
#    @guessed_code = guessed_code
       # assume both are arrays or check just in case? Probably OK because they are tested for validity on input
#  end


# main

m = Mastermind.new
m.play

# end main





