PEGS = %w(R G B Y O T).freeze

class HumanPlayer
  attr_reader :code
  attr_accessor :guess

  def initialize
    @code = []
    @guess = []
  end

  def prompt_for_code
    puts 'Enter your code. Select four of the following: R, B, G, O, Y, T'
  end

  def create_code
    prompt_for_code
    user_input = gets.chomp.upcase.split('')
    user_input.each { |peg| self.code << peg } 
    code
  end

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