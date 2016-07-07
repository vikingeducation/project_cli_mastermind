class Board < Array
  attr_reader :board

  def initialize
    @board = Array.new(12){ Array.new(4) }
  end

end
