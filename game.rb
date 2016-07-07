require_relative 'CodeMaker'
require_relative 'CodeBreaker'
require_relative 'Board'

class Game

  def initialize
    adrian = CodeBreaker.new("Adrian")
    vishal = CodeMaker.new("Vishal")
    board = Board.new
  end

  def play

  end

end

