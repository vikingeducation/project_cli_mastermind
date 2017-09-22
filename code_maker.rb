PEGS = %w(R G B Y O T).freeze

class CodeMaker
  attr_reader :code

  def initialize
    @code = []
    4.times { @code << PEGS.sample }
  end
end