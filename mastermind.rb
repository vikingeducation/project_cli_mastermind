require 'pry'
load 'board.rb'
load 'breaker.rb'
load 'display.rb'
load 'feedback_board.rb'
load 'maker.rb'
load 'player.rb'


class Mastermind
  include Display

  def initialize
    @codemaker = Maker.new
    @codebreaker = Breaker.new
    @turn = 1
  end

  def play
    intro
    @codemaker.set_code
    render(@codebreaker.board,
           @codemaker.board)
    loop do
      @codebreaker.guess
      @codemaker.feedback(@codebreaker.current_guess)
      render(@codebreaker.board,
             @codemaker.board)
      break if game_over?
    end
    salutations
  end

  def game_over?
    victory? || end_of_turns?
  end

  def victory?
    if (@codemaker.code.join == @codebreaker.current_guess.join)
      puts "Congrats you actually won.."
      return true
    end
    false
  end

  def end_of_turns?
    if @turn == 12
      puts "That's a shame, you lose......."
      return true
    end
    @turn += 1
    false
  end

end
