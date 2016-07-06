class Mastermind
  def initialize
    @guess_board = Board.new
    @fb_board = Board.new
    codemaker = Maker.new(@fb_board)
    codebreaker = Breaker.new(@guess_board)
    #var # of game turns max
  end

  def play

    # render board
    #
    # codebreaker guesses
    #
    # if victory / lose conditions are met
    # => Display the victory / lose msg
    # => break loop
    # else
    # => Codemaker provides feedback (white/red signals)
  end

  def game_over?
    victory? || end_of_turns?
  end

  def victory?
    # recent guess == code
  end

  def end_of_turns?
    # @board.full
  end

end


class Player

    def initialize(board)
      @board = board
    end

    def get_code_input

    end

end

class Maker < Player
  def set_code
    get_code_input
    set game code

  end

  def feedback

  end
end

class Breaker < Player
  def guess
    get_code_input
    make guess

  end
end

class Board
  def initialize
    @arr =[]
    12.times do
      arr2=[]
      4.times {arr2 << "-"}
      @arr << arr
    end
  end


end

class FeedBackBoard < Board

end
