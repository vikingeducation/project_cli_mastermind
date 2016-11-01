class Mastermind
  def initialize()
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @turns_left = 12
    @winning_sequence = @board.winning_sequence
  end

  def play
    instructions
    loop do
      take_turn
    end
  end

  def take_turn
    @codebreaker.make_guess

  end

  def instructions
    #
  end

  def gameover?
    gameover if @turns_left < 1
  end

  def gameover
    puts "Game over."
  end

  def win?
    @game_over  = true
  end

  def lose?
    #
  end
end

Mastermind.new.play


#Mastermind
  #play
  #gameover?
  #win?
  #lose?
