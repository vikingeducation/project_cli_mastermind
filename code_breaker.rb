class CodeBreaker
  attr_reader :guess

  def make_guess
    @guess = gets.chomp.upcase.split('')
    validate_guess
    @guess
  end

  def validate_guess
    until guess.length == 4 && guess.all? { |peg| PEGS.include?(peg) }
      puts 'Not a valid guess - try again!'
      make_guess
    end
  end
end
