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
    current_feedback = Array.new(4)

    # check all for exact matches first
    @code.each_with_index do |code_peg, index|
      if code_peg == guess[index]
        current_feedback[index] = "exact match"
        guess[index] = nil
      end
    end

    # then check for near matches
    @code.each_with_index do |code_peg, index|
      if current_feedback[index] != "exact match" && guess.include?(code_peg)
        current_feedback[guess.index(code_peg)] = "wrong place"
        guess[guess.index(code_peg)] = nil
      end
    end

    @feedback << current_feedback
    p current_feedback
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
      #print @feedback
      puts "Try again..."
    end

  end

  def display_solution
    print @code
  end

end