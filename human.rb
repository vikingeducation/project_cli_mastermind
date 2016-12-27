# require './string'

class Human < Player 
  def make_code
    peg = "\u25CF"
    puts "Please enter a code in the format '****'," 
    puts "where * represents the color of the peg."
    puts "The first color (letter) entered corresponds to the first position,"
    puts "the second color to the second position, and so forth."
    puts "~ Color codes:"
    puts " red #{peg.red} : 'r' |   green #{peg.green} : 'g' | yellow #{peg.yellow} : 'y'"
    puts "blue #{peg.blue} : 'b' | magenta #{peg.magenta} : 'm' |   cyan #{peg.cyan} : 'c'"
    puts "Example: 'rgyb' => [ #{peg.red} #{peg.green} #{peg.yellow} #{peg.blue} ]"
    puts "Your code >"
    input = gets.chomp
    until valid_code?(input)
      quit_game if input == 'q'
      puts "Invalid code! Please enter in format '****' (* = r, g, y, b, m, c):"
      input = gets.chomp
    end
    input.split('')
  end

  def guess(n, feedback)
    print "Guess ##{n} > "
    input = gets.chomp
    until valid_code?(input)
      quit_game if input == 'q'
      puts "Invalid guess! Please enter in format '****' (* = r, g, y, b, m, c):"
      input = gets.chomp
    end
    input.split('')
  end

  private

  def valid_code?(input)
    code_peg_array = input.split('')
    colors = %w(r g y b m c)
    return false unless code_peg_array.size == 4
    return false unless code_peg_array.all? { |code_peg| code_peg.size == 1 }
    code_peg_array.each do |code_peg|
      return false unless colors.include?(code_peg)
    end
    true
  end

end