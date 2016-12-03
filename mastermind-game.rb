class Game

  attr_reader @code
  
  def initialize
    @turns = 12
    @board = Board.new
    @player1 = Player.new
    @player2 = AI.new
    @code = @player2.generate_code
  end

  def play
    intro
    @board.render
    loop do
      announce_number_of_turns
      guess = @player.place_guess
      @board.process(guess)
      @board.render
      @turns -= 1
      if win?
        victory
        break
      elsif lose?
        sorry_dude
        break
      end        
    end
  end

  def win?
    guess == @code
    return true
  end

  def lose?
    if @turns == 0
    return true
    end
  end

  def victory
    puts "yay you won"
  end

  def sorry_dude
    puts "sorry dude you suck"
  end

  def intro
    puts "Welcome to Mastermind!"
    puts "This is how you play this game: ------"
  end

  def announce_number_of_turns
    puts "You have #{@turns} turns remaining."
  end

end

game = Game.new
game.play