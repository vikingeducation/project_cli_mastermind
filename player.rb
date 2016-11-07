class Player

  attr_accessor :code, :master_code

  def valid_code?(code)
    return false unless code.length == 4 && valid_chars?(code.chars)
    true
  end

  def valid_chars?(chars)
    valid_chars = %w(R B G Y O P)
    chars.all?{ |char| valid_chars.include?(char) }
  end
end

class Human < Player

  def guess_code
    puts "Codebreaker enter your code (e.g. brgo): "
    @code = get_code_input
  end

  def set_master_code
    puts "Choose your master code (e.g. brgo): "
    @master_code = get_code_input
  end

  def get_code_input
    colors = nil
    loop do
      colors = gets.chomp.upcase
      break if valid_code?(colors)
      puts "That wasn't a valid code! Enter in 'bgor' format!"
    end
    colors
  end
end

class Computer < Player

  def guess_code
    @code = generate_code
  end

  def set_master_code
    @master_code = generate_code
  end

  def generate_code
    code = ""
    valid_chars = %w(R B G Y O P)
    4.times {code << valid_chars.sample}
    code
  end
end
