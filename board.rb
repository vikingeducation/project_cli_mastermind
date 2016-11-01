class Board
  attr_reader :colors
  attr_writer :maker_sequence
  attr_accessor :turns
  def initialize(args={})
    @colors = args[:colors] || default_colors
    @maker_sequence = nil
    @turns = 0
  end

  protected
  def default_colors
    ['r', 'g', 'b', 'o', 'y', 'p']
  end
end