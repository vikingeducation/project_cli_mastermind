class Board

  def initialize

    @code = []
    @attempts = []
    @feedback = []

  end


  def render
    puts @attempts
  end


  def add_secret_code(input_code)
    @code = input_code
  end


  def check_exact_matches(guess)
    guess.each_with_index do |guess_peg, index|
      @feedback << "exact" if guess_peg == @code[index]
    end
  end

  def check_near_matches(guess)

  end


  def process_guess(guess = [])

    @attempts << guess
    if guess == @code
      puts "WIN!"
      exit
    else
      check_exact_matches(guess)
        # check near matches?
      print @feedback
      puts "Try again..."
    end

  end

  def display_solution
    print @code
  end

end