class Player
  def initialize
    @code = []
  end

  def reset
    @code = []
  end

  def check_quit
    exit if @code == 'q' || @code == 'quit'
  end

end

class Human < Player

  def make_code
    prompt_code until valid_code?
    @code
  end

  def get_code(board=nil, round=nil)
    self.make_code
  end

  def breaker_intro
    puts "Hello, Code Breaker!"
    puts "You have 12 opportunities to guess the 4-digit code."
    puts "Here are the 8 different coloured pegs available to guess from:"
    puts " 1 2 3 4 5 6 7 8".colourise
  end

  def maker_intro
    puts "Greetings, Code Maker!"
    puts "Please give me a code to crack."
    puts "Do make it hard, so that I may prove my worth!"
    puts "Here are the 8 different coloured pegs to create your code from:"
    puts " 1 2 3 4 5 6 7 8".colourise
  end

  def congratulations
    puts
    puts "Congratulations, Hooman!"
    puts "You've cracked the code."
    puts "Well, I guess that's that..."
    puts "Okay, goodbye!"
  end

  private

  def valid_code?
    @code.size == 4 && @code.all? {|g| g.between?(1,8)}
  end

  def prompt_code
    puts
    puts "Enter the code in the format '1234."
    puts "(Each digit must be a number between 1 and 8 inclusive)."
    @code = gets.strip
    check_quit
    @code = @code.split('').map(&:to_i)
  end
end

class AI < Player
  attr_reader :guess
  def make_code
    code = []
    4.times do
      code << rand(1..8)
    end
    code
  end

  def congratulations
    puts "Good game, Hooman!"
    puts "I had fun cracking that."
    puts "Well, goodbye!"
  end

  def get_code(board, round)
    # dumb version for now
    self.make_code
  end
end
