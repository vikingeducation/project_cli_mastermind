class Computer #AI for mastermind.rb

  CODE_COLORS = %w(b r y p g o)

  def initialize
    @solution = make_code
  end

  def solution
    @solution
  end

  def make_code
    code = []

    4.times do
      code << CODE_COLORS.sample
    end
    code
  end

  def guess
    make_code
  end

end