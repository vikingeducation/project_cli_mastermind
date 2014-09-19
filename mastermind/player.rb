
class Player

  def initialize(code=nil, game_type=1)
    @code=code
    if game_type == 2
      generate_code
    end
  end

  def make_guess(turns)
    loop do 
      guess = ask_for_guess(turns)
      return guess if valid_guess?(guess)
    end
  end

  def ask_for_guess(turns)
    puts "You have #{turns} turns remaining! Enter your guess: "
    gets.chomp.upcase
  end

  def valid_guess?(guess)
    guess.length == 4
  end

  def generate_code
    puts "Pick your super secret code and see if the AI can guess it! (ex AAAA, ABCD)"
    @player_code = gets.chomp.upcase
    puts "your code is #{@player_code}"
  end

  def get_code #this method exposes the player generated code when intializing the AI
    @player_code
  end
end
