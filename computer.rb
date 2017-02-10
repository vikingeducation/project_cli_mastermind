class Computer
  attr_reader :guess

  def initialize
    @guess = nil
  end

  def make_guess
    # naive algorithm #1 - random guessing
    guess = []
    4.times { guess << Mastermind::CODE_COLORS.sample }

    @guess = guess
  end
end
