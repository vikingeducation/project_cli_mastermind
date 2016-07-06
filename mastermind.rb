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
    puts "Welcome to Mastermind!"

    codemaker.set_code

    loop
      render(codebreaker.guess_board,
             codemaker.fb_board)
      codebreaker.current_guess

      break if game_over?
      # else
      # => Codemaker provides feedback (white/red signals)
      codemaker.feedback(codebreaker.current_guess)


    end

    # render

    # Game over message

  end

  def game_over?
    victory? || end_of_turns?
  end

  def victory?
    codemaker.code == codebreaker.current_guess
  end

  def end_of_turns?
    return true unless codebreaker.guess_board.include?(Array.new(4))
    false
  end

end
