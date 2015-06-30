require './input.rb'

class Player

  include Input

  attr_reader :player_num

  def initialize(player_num)
    @is_breaker = false
    @player_num = player_num
  end

  def is_breaker?
    @is_breaker
  end

  def set_role(val = true)
    @is_breaker = val
  end

  def play
    raise NotImplemented
  end

end

class Human < Player

  def play
    @is_breaker? code_breaker : code_maker
  end

  def code_breaker
    puts "#{@player_num} Guess the code!"
    new_guess = get_choice
    return new_guess
  end

  def code_maker
    puts "#{@player_num} Create a code!"
    new_condition = get_choice
    return new_condition
  end

end

class AI < Player

  def initialize(player_num)
    super(player_num)
    @guess_count = 0
    @memory = []
  end

  def play
    @is_breaker? code_breaker : code_maker
  end

  def get_educated_choice
    if @guess_count > (COLORS.length - 1)
      return @memory.shuffle
    else
      @guess_count += 1
      return [COLORS[@guess_count - 1],COLORS[@guess_count - 1],COLORS[@guess_count - 1],COLORS[@guess_count - 1]]
    end
  end

  # Takes hint and learns amount of colors in solution
  def learn(hint)
    if @guess_count < COLORS.length
      puts "Current memory: "
      count = hint.reject{|val| val == " "}.length

      count.times do
        @memory << COLORS[@guess_count - 1]
      end
    end
  end

  def code_breaker
    puts "The computer is selecting a move!"
    sleep (rand + 0.5)

    get_educated_choice
  end


  def code_maker
    choice = []

    puts "The computer is making a code!"

    4.times do
      choice << COLORS.sample
    end

  

    choice
  end

end