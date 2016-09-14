class Codemaker < Player

  def initialize(name)
    @name = name
    @computer = Computer.new
  end

  def turn(turn_num)
    if turn_num == 1
      orient
      make_code
    else
      print "Press enter to prompt the computer to make another guess."
      $player.quit if gets.upcase[0] == "Q"
    end
    @computer.guess(turn_num)
  end

  def orient
    puts "\nAs a Codemaker, your task is to create a pattern of four colored pegs from possible colors [R]ed, [O]range, [Y]ellow, [G]reen, [B]lue, and [V]iolet. Repeats are allowed! Your opponent (the computer) will then be allowed up to 12 attempts to guess the pattern and crack your code."
    print "\nSo, #{name}. "
  end

  def make_code
    puts "Please create the winning pattern below by listing colored pegs of your choice in order from peg 1 through peg 4."
    code = process_input
    if valid?(code) && code.size == 4
      $winning = code
      puts "\nShhh! The winning pattern for this game will be #{$winning.join("-")}."
    else
      puts "Something's not right. Try again, Codemaker #{name}."
      make_code
    end
  end

  def won
    puts "Your chosen code has eluded the computer! YOU WIN!"
    super
  end

  def lost(guess_num)
    puts "I'm afraid the computer cracked your code in #{guess_num} guesses."
    super
  end

end