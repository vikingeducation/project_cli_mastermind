require_relative 'board.rb'
require_relative 'breaker.rb'
require_relative 'display.rb'
require_relative 'feedback_board.rb'
require_relative 'maker.rb'
require_relative 'player.rb'


class Mastermind
  include Display

  def initialize
    codemaker = Maker.new
    codebreaker = Breaker.new

  end

  def play
    "Welcome to Mastermind!"

    codemaker.set_code
    
    loop
      Display.render(codebreaker.guess_board,
                     codemaker.fb_board)
      #
      # codebreaker guesses
      #
      break if game_over?
      # else
      # => Codemaker provides feedback (white/red signals)
    end

    # Game over message

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
