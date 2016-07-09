#board.rb

class Board

  def initialize
    @board = []
    @pegs = []
  end

  def collect_move(move, pegs)
    @board << move
    @pegs << pegs
  end

  def render
    puts render_all
  end

  private

  def render_all
    moves = ""
    @board.each_with_index do |move, index|
      move.each { |key, value| moves << "#{value} " }
      moves << " | "
      @pegs[index].each { |k, v| moves << "#{v} "}
      moves << "\n"
    end
    moves
  end

end
