class Parser

  def self.correct_input?(input)
    guesses = input.split(",")

    return false if guesses.length != 4
    guesses.all? { |guess| %w(a e i o u y).include?(guess) }
  end

  def self.create_code(input)
    move = input.split(",")
    hash_code = {}
    move.each_index { |index| hash_code[index] = move[index] } 
    hash_code
  end

end

