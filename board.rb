class Board
  attr_reader :colors
  attr_accessor :turns, :maker_sequence

  def initialize(args={})
    @colors = args[:colors] || DEFAULT_COLORS
    @maker_sequence = nil
    @turns = 0
  end

  protected
  DEFAULT_COLORS = ['r', 'g', 'b', 'o', 'y', 'p']

  def check_guess(sequence)
    arr = maker_sequence.dup
    exact_matches = []
    near_matches = []
    sequence.each_with_index do |color, i|
      if color == arr[i]
        exact_matches << 1
      else
        exact_matches << 0
      end
    end
  end
end