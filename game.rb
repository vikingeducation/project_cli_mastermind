class Game
  def initialize(attrs)
    @turns = 12
    @code_maker = attrs[:code_maker] || CodeMaker.new
    @code_breaker = attrs[:code_breaker] || CodeBreaker.new
  end

  def play
    welcome
    @secret_code = @code_maker.get_code
    @current_guess = @code_breaker.get_guess
    compare_guess_to_code
    win_check
  end

  def welcome
    puts "Welcome to Mastermind!"
  end

  def compare_guess_to_code
    if @current_guess == @secret_code
      you_win = true
    else
      # if ANYTHING is in exact right spot
      @exact_pegs = number_in_right_spot
      # if not in correct spot, is that color in yr guess array?
      @close_pegs = number_right_color
    end
  end

  def number_in_right_spot
    number_in_right_spot = 0
    4.times { |i| number_in_right_spot += 1 if secret_code[i] == @current_guess[i]}
    number_in_right_spot
  end

  def number_right_color
    # Make sure not to count one in exact position
  end

  def win_check
    if you_win == true
      puts "You nailed it! Go demand a free ice cream from your nearest retailer!"
    end
  end
# - turn
# - win conditions
end