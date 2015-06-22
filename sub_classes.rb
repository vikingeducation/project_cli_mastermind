module MasterMindHelper

  COLORS = [:r, :g, :b, :y, :c, :m]

  def feedback(guess)
    feedback = []
    remaining_guess = []
    remaining_code = []

    guess.each_with_index do |guess_v, guess_i|
      if guess[guess_i] == @code[guess_i]
        feedback << :black
      else
        remaining_code << @code[guess_i]
        remaining_guess << guess_v        
      end
    end

    COLORS.each do |color|
      if remaining_guess.include?(color) && remaining_code.include?(color)
        if remaining_code.count(color) > remaining_guess.count(color)
          (remaining_guess.count(color)).times { feedback << :white }
        else
          (remaining_code.count(color)).times { feedback << :white }
        end
      end
    end

    return feedback
  end
end


class SecretCode
  include MasterMindHelper
  attr_accessor :code

  def correct_code?(guess)
    if guess == @code
      return true
    end 
  end

  def create_secret_code
    # [:r, :r, :r, :r]
    array = []
    4.times { array << COLORS.sample }
    @code = array
  end
end


class Player
  attr_reader :guesses

  def initialize
    @guesses = 12
  end

  def get_guess(*args)
    input = ""
    loop do
      input_printer
      input = gets.chomp
      break if input_valid?(input)
    end
    @guesses -= 1
    return input.split("").map { |char| char.to_sym }
  end

  private

  def input_valid?(input)
    if input == "q"
      true
    else
      input = input.split("").keep_if { |chr| chr =~ /[rgbymc]/ }
      if input.length == 4
        true
      else 
        puts "Invalid Format!"
        false
      end
    end
  end  

  def input_printer
    puts "Enter the code using 4 of the following colors"
    print "'r' for red, ".colorize(:light_red)
    print "'g' for green, ".colorize(:light_green)
    print "'b' for blue, ".colorize(:light_blue)
    print "\n"
    print "'y' for yellow, ".colorize(:light_yellow)
    print "'c' for cyan, ".colorize(:light_cyan)
    print "'m' for magenta.".colorize(:light_magenta)
    print "\n"
    print "Enter your code (e.g. 'ryby') or 'q' to quit > "
  end
end


class AI
  include MasterMindHelper
  attr_reader :guesses, :possibles

  def initialize
    @guesses = 12
    @possibles = make_possibles
  end

  def get_guess(last_feedback=nil)
    if last_feedback == nil
      @last_guess = [:r, :r, :g, :g]
    else
      @code = @last_guess
      @possibles.keep_if do |p|
        feedback(p).count(:black) >=
        last_feedback.count(:black) &&
        feedback(p).count(:white) >=
        last_feedback.count(:white)
      end
      sleep 1
      @guesses -= 1
      @last_guess = optimal_guess
    end
  end

  def optimal_guess
    @possibles.sort do |px,py|
      (feedback(px).count(:black) + feedback(px).count(:white)) <=>
      (feedback(py).count(:black) + feedback(py).count(:white))
    end
    @possibles.pop
  end

  private

  def make_possibles
    possibles = []
    until possibles.length == 1296
      possible = []
      4.times do
          possible << COLORS.sample
      end
      unless possibles.include?(possible)
        possibles << possible
      end
    end  
    possibles
  end
end


class Board

  def initialize
    @turn_number = 1
    @feedbacks = {}
    @guesses = {}
  end

  def render_board(code=nil)
    system 'clear'
    puts "Welcome to Master Mind!  Can you guess the secret code?"
    print "\n"
    print ">> "
    code.nil? ? (print "(*)(*)(*)(*)") : colors(code)
    print " <<"
    print "\n"
    12.downto(1) do |turn|
      print "#{turn}".rjust(2)
      print " "
      @guesses[turn].nil? ? (print "(*)(*)(*)(*)") : colors(@guesses[turn])
      print " "
      @feedbacks[turn].nil? ? (print "") : colors(@feedbacks[turn])
      print "\n"
    end
    print "\n"
    puts "Code Breaker is given 12 guesses, feedback"
    puts "will be given for each."
    print "(*)".colorize(:color => :light_black)
    puts " - Correct color in the correct position!"  
    print "(*)".colorize(:color => :light_white)
    puts " - Code includes color in another position!" 
    print "\n" 
  end

  def store_guess(guess)
    @guesses[@turn_number] = guess    
  end

  def store_guess_feedback(feedback)
    @feedbacks[@turn_number] = feedback
    @turn_number +=1
  end

  private

  def colors(array)
    colors = {r: :light_red, 
              b: :light_blue, 
              g: :light_green, 
              y: :light_yellow, 
              m: :light_magenta, 
              c: :light_cyan,
              black: :light_black,
              white: :light_white}

    array.each do |peg|
      print "(*)".colorize(:color => colors[peg])
    end
  end
end