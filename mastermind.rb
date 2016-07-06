class Game
  def initialize
    @board = Board.new()
    @player = Player.new()
    @code = Code.new(:computer)
  end
end


class Board
  def initialize
  end
end


class Player
  def initialize
  end
end


class Code
  COLORS = ["red", "blue", "green", "purple", "yellow", "orange"]
  
  def initialize(answer = Code.generate)
    @answer = answer
  end

  def self.generate
    4.times.map {COLORS.sample} 
  end
end