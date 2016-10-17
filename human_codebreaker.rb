class HumanCodebreaker

  def initialize(colours, board)
    @colours = colours
    @board = board
  end

  def get_combination
    loop do
      guess = ask_for_combination #i.e. ["R", "O", "B", "G"]
      if validate_combination(guess)#it's true
        @board.add_pegs(guess)
        break
      end
    end
  end

  protected

  def ask_for_combination
    puts
    puts
    puts "Take a guess, what is the secret combination of the colours?"
    puts "Please choose 4 colours from the following (colours might be duplicated):"
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