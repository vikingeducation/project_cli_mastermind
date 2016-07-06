class Game

  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to Mastermind!!"
    assign_players
    @codemaker.set_master_code
    until game_over?
      turn
    end
    final_message
  end

  def turn
    @codebreaker.guess_code
  end

  def assign_players
    until @codemaker
      puts "Would you like to play as Codemaker(m) or Codebreaker(b)? "
      choice = gets.chomp
      if choice == "m"
        @codemaker = Human.new
        @codebreaker = Computer.new
      elsif choice == "b"
        @codemaker = Computer.new
        @codebreaker = Human.new
      end
    end
  end
end

class Player
  def valid_code?(code)
    return false unless code.length == 4 && valid_chars?(code.chars)
    true
  end

  def valid_chars?(chars)
    valid_chars = %w(r b g y o p)
    chars.all?{ |char| valid_chars.include?(char) }
  end
end



class Human < Player

  def guess_code
    get_code_input
  end

  def set_master_code(code)
    @master_code = code
  end

  def get_code_input
    colors = nil
    loop do
      puts "Codebreaker enter your code: e.g. brgo"
      colors = convert_to_code(gets.chomp)
      break if valid_code?(colors)
      puts "That wasn't a valid code! Enter in 'bgor' format!"
    end
    @code = colors
  end

#todo
  def convert_chars_to_code(chars)
    colors_hash = { r: :red, b: :blue, g: :green,
                    y: :yellow, o: :orange, p: :purple }
    colors = chars.map { |color| colors_hash[color.to_sym] }
  end



end

class Computer < Player

  def guess_code
  end
end

class Peg
end

class KeyPeg < Peg
end

class CodePeg < Peg
end
