# CLI Mastermind -- Story 1

# DRAFT 1
# -------

# Note. Could write as "Module Mastermind" containing "Class Game"
#       (replacing "Class Mastermind") and all other classes, in 
#       order to encapsulate the whole game. 

require "yaml"

class Mastermind

  # initialize (set up game)
  def initialize 

  end

  # play
  def play

    # if saved file exists, load data 
    if File.exists?("saved_game.yaml", "w")
      load_game
    else  
      start_game
    end

    @board = Board.new(code, guessed_code) 
    @messages = Messages.new
    @messages.welcome(guess_attempts) # explains rules

    loop do
      guess_attempts += 1
      guessed_code, code_set = @codebreaker.guess_code(guessed_code, black_pegs, white_pegs, code_set) # these arguments refer to values from PREVIOUS loop; they are used only when codebreaker = computer in order to calculate the next guessed_code (see code there)
      black_pegs, white_pegs = @board.feedback_and_display(code, guessed_code)  # white pegs needed only when codebreaker = computer for analysis next time round the loop
      @messages.victory(code) if @board.guess_correct?(black_pegs)
      @messages.defeat(code) if guess_attempts >= 12
      loop do
        save_game?
      end
    end
  end

  def load_game
    @mastermind = YAML::load(File.read("save_game.yaml"))
  end

  def save_game?

    File.open("saved_game.yaml", "w") do |file|
      file.puts YAML::dump(@mastermind)
    end
  end

  def start_game
    # decide roles for of human and computer players
    # then instances are created for them in this method
    @codemaker, @codebreaker = decide_roles
 
    # create code
    code = @codemaker.create_code

    guess_attempts = 0
    guessed_code = []
    black_pegs = 0
    white_pegs = 0
    code_set = [] # used when codebreaker - computer to calculate a new guessed_code 

    # set up Player, Human, Computer - or are saved @codemaker, @codebreaker sufficient? (Note: each = Human.new or Computer.new). Assume for now that these saved instance variables are sufficient)
  end

  def decide_roles
    puts "do you want to play codemaker or codebreaker?"
    loop do
      print "enter CM or CB :"
      answer = gets.chomp
      case answer
      when "CM"
        @codemaker = Human.new
        @codebreaker = Computer.new
        break
      when "CB"
        @codemaker = Computer.new
        @codebreaker = Human.new
        break
      else
        print "incorrect input - "
      end
    end
    puts "the computer will play the other role"
    return @codemaker, @codebreaker
      # note: classes Computer and Human are children of Player
  end

end   # end class Mastermind


class Board

  attr_accessor :code,  :guessed_code  # because passed through deom create_code

     # Use @code to replace "code" argumants below

  # initialize board
  def initialize(code, guessed_code)
    @code = code
    @guessed_code = guessed_code
  end
  
  # I do not see the need to initialize pegs and colors. They are contained in "code" and "guessed_code" arrays. That is "position of peg" = position in array; and "color" array item value,  represented by range 1 thru 6.
 
# feedback and display response (umbrella method)
  def feedback_and_display(code, guessed_code)
    code, guessed_code, black_pegs, white_pegs = feedback(code, guessed_code)
    display_feedback(code, guessed_code, black_pegs, white_pegs)
    black_pegs

      # note: I could make a short cut:
        # "display_feedback(guessed_code, black_pegs, white_pegs) = feedback(code, guessed_code)" 
      # however, I think that is a risk because the reader may not easily understand what is going on.
  end

  def feedback(code, guessed_code)
    black_pegs = 0
    white_pegs = 0
    temp_code = code.dup
    temp_guessed_code = guessed_code.dup

    4.times do |position|
      if temp_code[position] == temp_guessed_code[position]
        black_pegs += 1
        temp_code[position], temp_guessed_code[position] = "X" # this is to prevent these digits from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
      end
    end


    4.times do |position|
      next if temp_guessed_code[position] == "X" 
      4.times do |temp_code_position|
        if temp_code[temp_code_position] == temp_guessed_code[position]
          white_pegs += 1
          temp_code[temp_code_position] = "X" # this is to prevent this digit from being considered again as "the correct color but in another position" if a digit of the same color is found later on in the feedback of this guess. 
          next
        end
      end
    end

    return code, guessed_code, black_pegs, white_pegs
  end

  def display_feedback(code, guessed_code, black_pegs, white_pegs)
    puts "\nFeedback:"
    print "code: "XXXX ..."
    print "code: #{code.join} ... " 
      # for testing purposes only 
    print "guessed code: #{guessed_code.join} ... "
    print "black pegs: #{black_pegs} ... "
    puts "white pegs: #{white_pegs}"
  end

  def guess_correct?(black_pegs)
    if black_pegs == 4
    end
  end

end   # end class Board


class Player

  # note: classes Computer and Human are children of Player

  attr_accessor :name, :code, :guessed_code #do I need :code and :guessed_code - as not imported into class but exported out? So far :name is not used so not necessary now

  def initialize 
    # empty method is necessary (I believe) to create instance
    # however, no ditrect creation of Player instance is created (only those of its children)
    # presumably, therefore, this method is not necessary?
  end

  # common sub-method called by Human class create_code and guessed_code methods to create a code manually. User can optionally save game here.
  def input_digits # manually
    digits = []
    loop do
      print "Enter guess: 4 digits (each 1, 2, 3, 4, 5 or 6 - eg, 1234): "
      digits = gets.chomp
      break if ("1111".."6666").include?(digits)
      puts "Incorrect code - try again"
    end
    digits_array = digits.split("") 
  end

  # common sub-method called by Computer class create_code and guessed_code methods
  def digits_create_randomly
    digits_array = []
    4.times do
      digits_array << rand(1..6).to_s
    end
    digits_array
  end

end  # end class Player

class Human < Player

  # attr_accessor inherited from parent class

  def initialize
  end

  # codemaker creates code (to be guessed)
  def create_code
    code = input_digits
  end

  # codemaker guesses code 
  def guess_code(guessed_code, black_pegs, white_pegs, code_set) # these arguments are NOT used here; they refer to values from PREVIOUS loop and are used only when codebreaker = computer in order to calculate the next guessed_code (see code there)
    guessed_code = input_digits
    guessed_code, code_set
  end

end

# end class Human

class Computer < Player

  include Enumerable

  # attr_accessor inherited from parent class

  def initialize
    @code_set # TODO 
  end

  # codemaker creates code (to be guessed)
  def create_code
    code = digits_create_randomly
  end

  # codemaker guesses code randomly (in Story 2)
  # def guess_code
  #   guessed_code = digits_create_randomly
  # end

  # codemaker guesses code through artifical intelligence (AI) (in Story 3)
  def guess_code(guessed_code, black_pegs, white_pegs, code_set)  # these arguments refer to values from PREVIOUS loop and are used in order to calculate the next guessed_code
    if guessed_code = [] # initial guessed_code value now set
      guessed_code = ["1", "1", "2" "2"]
      return guessed_code
    end
    digits_create_by_AI(guessed_code, black_pegs, white_pegs, code_set)
  end

  def digits_create_by_AI(guessed_code, black_pegs, white_pegs, code_set) 
      # create set of possible codes for AI to start guessing the code
    if code_set = []
      ("1111".."6666").each do |num|    # create initial code set
        code_set << num.split("")
    end
    
      # AI goes through set of possible codes. It compares each one to the guessed_code. When feedback does not result in the same number of black and white pegs as produced with feedback against the real code, the possible code is dropped from the code_set (because it cannot be the real code).
    code_set.select! do |trial_code|
      trial_code, guessed_code, trial_code_black_pegs, trial_code_white_pegs = @board.feedback(trial_code, guessed_code)
        trial_code_black_pegs == black_pegs && trial_code_white_pegs == white_pegs # thus delete unless this condition is true
    end
    guessed_code = code_set[0]
    guessed_code, code_set
  end

end

# end class Computer

class Messages

  def welcome(guess_attempts)
    if guess_attempts > 0
      resume_phrase_1 = "back"
      resume_phrase_2 = "You have already had #{guess_attemots} guesses."
    else
      resume_phrase_1, resume_phrase_2 = ""
    end
    puts %{ 

      Welcome #{resume_phrase_1 }to Mastermind! Are you a champion?

      RULES: The codemaker creates a 4-digit code. Each digit 
      (representing a color) is in the range 1 - 6. 
      For example, "1234". The codebreaker has 12 guesses
      to crack the code. After that he/she loses. 
        
      After a guess the codebreaker will get this feedback:
      1. the guessed code
      2. number of black pegs
      3. number of white pegs
      
      Each black (or "exact") peg means you have guessed the
      right color and position of ONE of the code digits.
      Each white (or "close") peg means you have guessed the
      right color of ONE of the code digits but it is in ANOTHER
      position.
        
      #{resume_phrase_2} Let's begin!
    }     
  end      

  def victory(code)
    puts "\nvictory! You have cracked the code: #{code.join} \n\n"
    exit
  end

  def defeat(code)
    puts "\nsorry! You have exceeded 12 guesses. Game lost. Better luck next time!"
    puts "codemaker's code was #{code.join} \n\n"
    exit
  end

end 

# end class Messages


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




