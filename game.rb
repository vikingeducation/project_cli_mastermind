# have two players, in instance variables.
# consider calling them "codemaker" & "codebreaker"
# decide if each player is human or computer
# decide based on command line input
# fill in win and game over methods




class Game

  COLORS = %w[orange green red blue purple yellow]

  attr_accessor :player_guess, :secret_code

  def initialize
    @board = Board.new
    @secret_code = @board.generate_code
    @turns = 0
    @player1 = Player.new
    # add player2?
    @player_guess = []
  end
  
  def play
    welcome_message
    until game_over? || win?
      increase_turns
      @player_guess = @player1.get_move
      @board.render
    end
    exit_message
  end

  def welcome_message
    puts "Welcome to Mastermind."
  end

  def exit_message
    puts "Thanks for playing Mastermind!"
  end

  def increase_turns 
    @turns += 1
  end



  def game_over? 
  end

  def win? # make two different methods
  end

    if @turns == 12 
      puts "You are out of turns."
      true
    elsif @player_guess == @secret_code
      puts "You solved the secret code."
      true
    else
      false
    end
  end



end