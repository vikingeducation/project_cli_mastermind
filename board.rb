class Board

  def initialize
    @code = []
    @attempts = []
    @feedback = []
  end

  def render
    print @attempts
  end

  def add_secret_code(input_code)
    @code = input_code
  end

  def process_guess(guess = [])
    @attempts << guess
    if guess == @code
      puts "WIN!"
      exit
    else
      puts "Try again..."
    end
    render
  end



end