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
      # if not in correct spot, is that color in yr guess array?
    end
  end

  def win_check
    if you_win == true
      puts "You nailed it! Go demand a free ice cream from your nearest retailer!"
    end
  end
# - turn
# - win conditions
end