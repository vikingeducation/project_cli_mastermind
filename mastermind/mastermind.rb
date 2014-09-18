class Mastermind
  def initialize
    gen_code
    @player=Player.new(gen_code)
    @turns_left=12
  end
  def gen_code
   #generate the random code to start the game
   code=[]
   4.times do
       code << (rand(6).ceil + 65).chr
   end
   @code=code.join('').to_s
   @code
  end

  def play 
    loop do
      check_guess(@player.make_guess(@turns_left))
      gen_output(@result)
      break if game_over?
    end
  end

  def check_guess(guess)
    @guess=guess
    result=[]
    0.upto(3) do |i|
      if guess[i] == @code[i]
        result << 'R'
      elsif @code.include? guess[i]
        if (result.count('R') + result.count('W') < @code.count(@code[i]))
          result << 'W' 
        else
          result << ' '
        end
      end
    end
    @result = result
  end

  def gen_output(result)
    if result.join('').to_s == "RRRR"
        puts "You win!\nYou guessed the correct code in #{13-@turns_left} turns!\n"
        @turns_left = 1
    else
        puts "Guess: #{@guess}        Result: #{result}"
    end
    @turns_left-=1
  end


  def game_over?
    if @turns_left == 0
      puts "The code was #{@code}."
      true
    end
  end

end




class Player

  def initialize(code)
    @code=code
  end

  def make_guess(turns)
    loop do 
      guess = ask_for_guess(turns)
      return guess if valid_guess?(guess)
    end
  end

  def ask_for_guess(turns)
    puts "You have #{turns} turns remaining! Enter your guess: #{@code} "
    gets.chomp.upcase
  end

  def valid_guess?(guess)
    guess.length == 4
  end
end

m=Mastermind.new
m.play