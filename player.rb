# The Player class is responsible for handling all the player interations for
# the Mastermind game.
class Player
  private

  def ask_input
    puts 'Please enter an input in the form "#, #, #, #" where # is your'
    puts 'numerical guess'
    gets.chomp
  end

  # This method smells of :reek:UtilityFunction
  def validate_input(input)
    check = /^
      \s*(?<num1>\d)\s*,
      \s*(?<num2>\d)\s*,
      \s*(?<num3>\d)\s*,
      \s*(?<num4>\d)\s*
    $/x
    check.match(input)
  end

  def error_input
    puts 'The input given was incorrect.'
  end

  # This method smells of :reek:UtilityFunction
  def format_input(input)
    [input[:num1], input[:num2], input[:num3], input[:num4]].map(&:to_i)
  end
end

# The Human class is responsible for handling Human interactions around the
# Player class
class Human < Player
  def guess
    input = {}
    loop do
      input = validate_input(ask_input)
      break if input
      error_input
    end
    format_input(input)
  end

  def code
    guess
  end
end

# The Computer class is responsible for handling Computer interactions around
# the Player class
class Computer < Player
  def code
    Array.new(4) { rand(0..9) }
  end

  def guess
    move = Array.new(4) { rand(0..9) }
    puts "Computer makes move: #{move}. Push enter to continue"
    gets
    move
  end
end
