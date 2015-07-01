=begin
Set up game initiallly (Mastermind)
  create game board (Board)
  create CodeMaker (CodeMaker)
  create CodeBreaker (CodeBreaker)
  create code (CodeMaker)

start game loop (Mastermind)
  reader game board (Board)
  ask for and validate player's guess (CodeBreaker)
  If the game should end (Mastermind)
    Display the proper message
    stop looping
  else
    add to guess_count (CodeBreaker)
    keep looping (Mastermind)
=end



class Mastermind

	# initialize
  def initialize
		# set up the board
    @board = Board.new
    # set up guess limit
    @guess_limit = 12
  end

  def welcome
    puts "Welcome to Mastermind!"
    puts "Enter guesses in the form of bbbb "
    puts "The code consists of any combination of "
    puts "(b)lue, (g)reen, (y)ellow, (o)range, (p)urple, or (r)ed."
    puts "You have 12 tries. Good luck!"
  end

  def play(play_code_breaker = true)
    welcome

    # set up codemaker and codebreaker
    if play_code_breaker
      @code_maker = Computer.new(@board)
      @code_breaker = CodeBreaker.new(@board)
    else
      @code_maker = CodeMaker.new(@board)
      @code_breaker = AI.new(@board)
    end

    @code_maker.get_code
		
    # loop 12 times
    @guess_limit.times do

			# ask for guess from codebreaker
      @code_breaker.get_guess
      # call board rendering method
      @board.render
			# break the loop IF game is over
      break if @board.check_victory?
    end


    if @board.check_victory?
      puts "The guess is correct!"
    else
      puts "You're out of guesses!" 
      print "The code is: "
      @board.show_code
    end
  end

end

# Manages all board functionality
class Board

	def initialize
		@board = []
  end

	def render
		@board.each do |guess|
      feedback = generate_feedback_key(guess)
      print guess
      print "     "
      print feedback
      print "\n"
    end
    puts "---------------------------------------"
  end

  def add_guess(guess)
    @board << guess
  end

  def add_code(code)
    @code = code
  end

  def show_code
    @code.each {|c| print c+" "}
  end

  def check_victory?
    @board[-1] == @code
  end

  def generate_feedback_key(guess)
    @feedback_key = []
    code_dup = @code.dup
    index_black_list = []
    guess.each_with_index do |p, i|

      if p == code_dup[i]
        @feedback_key << "b"
        code_dup[i] = "q"
        index_black_list << i
      end
    end

    guess.each_with_index do |p, i|
      if code_dup.include?(p) && !index_black_list.include?(i)
        @feedback_key << "w"
      end
    end
    @feedback_key.sort
  end

end

class CodeBreaker
  PEG_COLORS = %w( b g o r p y)

  def initialize(board)
    @board = board
  end

  def get_guess
    loop do
      guess = ask_for_guess
      if is_valid_guess?(guess)
        @board.add_guess(guess)
        break
      end
    end
  end

  def ask_for_guess
    p "Enter guess >> "
    guess = gets.chomp.split("")
  end

  def is_valid_guess?(guess)
    if guess.length != 4
      p "Guess must exactly be 4 colors."
      return false
    end
    guess.each do |p|
      unless PEG_COLORS.include?(p)
        p "#{p} is not a valid color."
        return false
      end
      return true
    end
  end
end

class CodeMaker
  PEG_COLORS = %w( b g o r p y)

  def initialize(board)
    @board = board
  end

  # get_codes
  def get_code
    loop do # until or while
      code = ask_for_code
      if is_valid_code?(code)
        @board.add_code(code)
        break
      end
    end
  end

  def ask_for_code
    p "Enter code >> "
    code = gets.chomp.split("")
  end

  def is_valid_code?(code)
    code.each do |p|
      unless PEG_COLORS.include?(p)
        p "#{p} is not a valid color."
        return false
      end
      return true
    end
  end

end

class Computer < CodeMaker

  def get_code
    code = []
    4.times do
      code << PEG_COLORS.sample
    end
    @board.add_code(code)
  end

end


class AI < CodeBreaker

  def initialize(board)
    super(board)
    @guess = [0, 0, 1, 1]
    @candidates = generate_possible_solutions
  end

  def get_guess
    @board.add_guess(convert_num_to_guess(@guess))
    generate_guess
  end

  # codes = [all posibile codes]
  #
  # initial_guess = 0011
  #
  # loop
  #   feedback = get_feedback(initial_guess, real_code)

  #   codes.each do |code|
  #     if get_feedback(initial_guess, code) == feedback
  #       remove code from codes
  #     end
  #   end

  #   initial_guess = codes[0]
  # end

  def generate_guess
    feedback = @board.generate_feedback_key(convert_num_to_guess(@guess))

    @candidates = @candidates.select do |c|
      get_feedback(convert_num_to_guess(@guess), convert_num_to_guess(c)) == feedback
    end

    @guess = @candidates[0]
  end

  def generate_possible_solutions
    candidates = []
    vals = [0, 1, 2, 3, 4, 5]
    vals.each do |v1|
      vals.each do |v2|
        vals.each do |v3|
          vals.each do |v4|
            candidates << [v1, v2, v3, v4]
          end
        end
      end
    end
    candidates
  end

  def convert_num_to_guess(nums)
    nums.map {|i| PEG_COLORS[i]}
  end

  def get_feedback(guess, code)
    feedback_key = []
    code_dup = code.dup
    index_black_list = []
    guess.each_with_index do |p, i|

      if p == code_dup[i]
        feedback_key << "b"
        code_dup[i] = "q"
        index_black_list << i
      end
    end

    guess.each_with_index do |p, i|
      if code_dup.include?(p) && !index_black_list.include?(i)
        feedback_key << "w"
      end
    end

    feedback_key.sort
  end
end 


