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
      take_turn unless game_over?
    end
  end

  def take_turn
    guess = @codebreaker.make_guess
    @board.add_row(guess)
    if guess == @winning_sequence
      win
    end
    @turns_left -= 1
  end

  def instructions
    #
  end

  def gameover?
    gameover if @turns_left < 1
  end

  def gameover
    puts "Game over."
    exit
  end

  def win?
    @game_over  = true
  end

  def win
    puts "You win!"
    exit
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
