class Game
  # red, blue, green, orange, yellow, white
  COLORS = %w(r b g o y w)
  @@code_sequence = []

  def initialize(choice)
    if choice.to_i == 1
      @breaker = Human.new("you")
      @maker = Computer.new
    elsif choice.to_i == 2
      @breaker = Computer.new("the Computer")
      @maker = Human.new
    end
  end

  def play
    # generate code
    @@code_sequence = @maker.generate_code

    (1..12).each do |turn|
      puts "This is chance #{turn} of 12 for #{@breaker.possessive}."
      current_guess = @breaker.guess_code
      pending = evaluate_guess(current_guess)

      if pending[:exact].length == 4
        puts "You have won the game!"
        return
      else
        puts "#{pending[:exact].length} Exact Matches"
        puts "#{pending[:near].length} Near Matches"
        puts "#" * 10
        puts
      end
    end

    puts "You LOSE!"
    puts "The winning combination was actually #{@@code_sequence.join(",")}"
    return
  end

  def evaluate_guess(current_guess)
    results = { :exact => [], :near => [] }
    current_guess.each_with_index do |choice, position|
      if exact_match?(choice, position)
        results[:exact] << true
      elsif near_match?(choice)
        results[:near] << true
      end
    end
    results
  end

  def exact_match?(choice, position)
    choice == @@code_sequence[position]
  end

  def near_match?(choice)
    @@code_sequence.include?(choice)
  end

end

class Human

  attr_reader :possessive

  def initialize(label=nil)
    @possessive = label
  end

  def generate_code
    puts "Generate a code for the computer to break!\nChoose 4 colors: red, blue, green, orange, yellow, or white.\nFirst letters only and separated by commas.\nFor example: g,y,o,r"
    @code = gets.chomp
    @code_sequence = @code.downcase.split(",")
    return @code_sequence
  end

  def guess_code
    puts "Crack the code!\nChoose 4 colors in the correct sequence.\nFirst letters only and use commas."
    @guess = gets.chomp
    @guess.downcase.split(",")
  end

end

class Computer

  attr_reader :possessive

  def initialize(label=nil)
    @possessive = label
  end

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
