class Codebreaker < Player

  def initialize(name)
    @name = name
  end

  def turn(turn_num)
    if turn_num == 1
      orient
      make_code
    elsif turn_num == 12
      puts "And now, for your final guess!"
    end
    make_guess(turn_num)
  end

  def orient
    puts "\nAs a Codebreaker, your task is to uncover a winning pattern of four colored pegs in 12 or fewer guesses. The possible colors include [R]ed, [O]range, [Y]ellow, [G]reen, [B]lue, and [V]iolet. Please note that colors may be repeated within the same pattern. For each guess, you will have the opportunity to enter up to four colors in a specific order. You will receive feedback on each guess made that can help you to logically move toward deducing the correct pattern. Every '!' you see in the feedback column indicates that 1 colored peg is in the correct position. Every '*' you see indicates that there is a correctly-colored peg in the wrong position. Each 'X' indicates a miss or blank."
    print "\nSo, #{name}. "
  end

  def make_code
    $winning = []
    4.times { $winning << POSS_PEGS.sample }
  end

  def make_guess(turn_num)
    puts "Please enter your guess, by color in order, below."
    guess = process_input
    if valid?(guess)
      guess << "-" until guess.size == 4
      $guess = Guess.new(turn_num, guess)
    else
      puts "\nSomething's not right. Try again, Codebreaker #{name}."
      print "\n"
      make_guess(turn_num)
    end
  end
  
  def won(guess_num)
    puts "You cracked the code in #{guess_num} guesses! YOU WIN!"
    super
  end

  def lost 
    puts "I'm afraid that was your final guess. The pattern was actually #{$winning}." 
    super
  end

end