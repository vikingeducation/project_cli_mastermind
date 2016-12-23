require_relative 'player'
require_relative 'board'
require_relative 'string'

class Mastermind

  def initialize
    @board = Board.new
    @code_breaker
    @code_maker

  end

  def play
    welcome
    get_mode
    create_players

    @code = @code_maker.make_code

    12.times do |round|
      @guess = @code_breaker.get_code(@board, round)
      feedback = @board.get_feedback(@guess, @code)
      @board.update(@guess)
      @board.render

      congratulate_winner if code_cracked?
      reset_round
    end

    game_over

  end

  private

  def game_over
    puts
    puts "Sorry, you're out of turns!"
    puts "The code was #{@code.join(' ').colourise}."
    puts "Better luck next time!"
  end

  def congratulate_winner
    @code_breaker.congratulations
    exit
  end

  def code_cracked?
    @guess == @code
  end

  def reset_round
    @code_breaker.reset
    @board.reset
  end

  def create_players
    if @mode == '1'
      @code_breaker, @code_maker = Human.new, AI.new
      @code_breaker.breaker_intro
    else
      @code_breaker, @code_maker = AI.new, Human.new
      @code_maker.maker_intro
    end
  end


  def get_mode
    until valid_mode?
      puts "Choose your game mode:"
      puts "Enter '1' to play as code breaker, '2' to play as code maker."
      puts "Enter 'q' at any time to quit."
      @mode = gets.strip
      puts
    end
  end

  def valid_mode?
    exit if @mode == 'q' || @mode == 'quit'
    @mode == '1' || @mode == '2'
  end

  def welcome
    puts
    puts "Welcome to Mastermind!"
    puts
  end

end

m = Mastermind.new
m.play
