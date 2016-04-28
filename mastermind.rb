class Game
  # red, blue, green, orange, yellow, white
  COLORS = %w(r b g o y w)
  @@code_sequence = []

  def initialize(choice)
    if choice.to_i == 1
      @breaker = Human.new
      @maker = Computer.new
    elsif choice.to_i == 2
      @breaker = Computer.new
      @maker = Human.new
    end
  end

  def play
    # generate code
    @@code_sequence = @maker.generate_code

    
  end

end

class Human

  def generate_code
    puts "Generate a code for the computer to break!\nChoose 4 colors: red, blue, green, orange, yellow, or white.\nFirst letters only and separated by commas.\nFor example: g,y,o,r"
    @code = gets.chomp
    @code_sequence = @code.downcase.split(",")
    return @code_sequence
  end

end

class Computer

  def generate_code
    @colors = Game::COLORS.shuffle
    @code_sequence = []
    4.times do
      @code_sequence << @colors.pop
    end
    return @code_sequence
  end

end

puts "Welcome to MASTERMIND!\nEnter (1) to be a CODEBREAKER.\nEnter (2) to be a CODEMAKER:"
g = Game.new(gets.chomp)
g.play
