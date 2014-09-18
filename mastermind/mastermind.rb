class Mastermind
  def initialize(game_type)
    @turns_left=12
    if game_type == 1
      gen_code
      @player=Player.new(gen_code)

      play(game_type)
    else
      @player=Player.new(nil,2)
      @code=@player.get_code
      @ai=AI.new(@code)
      play(game_type)
    end
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

  def play(game_type)
    if game_type == 1
      loop do
        check_guess(@player.make_guess(@turns_left))
        gen_output(@result)
        break if game_over?
      end
    else
      loop do
        check_guess(@ai.make_guess(@turns_left))
        gen_output(@result)
        break if game_over?
      end
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

class AI
  def initialize(code)
    @code=code
  end
  def make_guess(result)
    guess='AAAA'
    puts "The AI guessed #{guess}.\n"
    guess
  end

end


