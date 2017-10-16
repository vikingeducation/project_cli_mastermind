class HumanCodemaker

  def initialize(colours)
    @colours = colours
  end

  def get_combination
    guess = []
    loop do
      guess = ask_for_combination #i.e. ["R", "O", "B", "G"]
      if validate_combination(guess)#it's true
        break
      end
    end
    guess
  end

  private

  def ask_for_combination
    puts
    puts
    puts "Create a code, a secret combination of the colours for the codebreaker?"
    puts "Please choose 4 colours from the following... you can duplicate some of them if you choose:"
    puts "RED BLUE GREEN PURPLE YELLOW ORANGE"
    puts "You can make a guess by typing the first letter of each colour in the following pattern: R-G-B-B"
    puts
    puts
    gets.strip.upcase.split("-")
  end

  def validate_combination(combination)
    correct_picks = combination.select {|colour| (@colours.join).include?(colour)}
    if correct_picks.size == 4
      true
    else
      puts "You have typed incorrect pattern. Please provide correct colour combination guess."
    end
  end

end