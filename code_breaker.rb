class CodeBreaker
  attr_accessor :guess

  def make_guess
    self.guess = gets.chomp.upcase.split('')
    validate_guess
    guess
  end

  private

  def validate_guess
    until guess.length == 4 && guess.all? { |peg| PEGS.include?(peg) }
      puts 'Not a valid guess - try again!'
      make_guess
    end
  end
end
