class Board

  def initialize

    @code = []
    @attempts = []
    @feedback = []

  end


  def render
    system("clear")
    @attempts.size.times do |index|
      attempt = @attempts[index].join("-")
      feedback = @feedback[index].join(" ")
      puts "#{index + 1}) #{attempt} : #{feedback}"
    end
    puts "\nX - correct number and placement"
    puts "O - correct number but incorrect placement \n\n"

  end


  def add_secret_code(input_code)
    @code = input_code
  end




  def check_answer(guess)
    current_feedback = Array.new(4) { "_" }

    # check all for exact matches first
    @code.each_with_index do |code_peg, index|
      if code_peg == guess[index]
        current_feedback[index] = "X" # exact match = X
        guess[index] = nil
      end
    end

    # then check for near matches
    @code.each_with_index do |code_peg, index|
      if current_feedback[index] != "X" && guess.include?(code_peg)
        current_feedback[guess.index(code_peg)] = "O" # near match = O
        guess[guess.index(code_peg)] = nil
      end
    end

    @feedback << current_feedback
    p current_feedback
  end




  def process_guess(guess = [])
    @attempts << guess.dup

    if guess == @code
      puts "The Codebreaker has won!"
      exit
    else
      check_answer(guess)
      puts "Not the secret code.  Please try again:"
    end
  end


  def display_solution
    puts "The actual solution was: #{@code}!"
  end


end