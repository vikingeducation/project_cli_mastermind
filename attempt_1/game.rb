class Game
  def initialize(args = {})
    @board = args[:board]         || Board.new
    @codebreaker = args[:breaker] || HumanPlayer.new
    @codemaker = args[:maker]     || ComputerPlayer.new
    play
  end

  def play
    Render.welcome @board.colors
    Render.sequence_instuctions @board.colors

    @board.maker_sequence = @codemaker.get_sequence(@board.colors)
    until win? || lose?
      Render.sequence_instuctions(@board.colors)
      @guess = @codebreaker.get_sequence(@board.colors)
      results = @board.check_guess @guess
      Render.game_board(results, @guess)
      @board.turn
    end
  end

  def win?
    @guess == @board.maker_sequence
  end

  def lose?
    @board.turns == 12
  end

  protected
  

end