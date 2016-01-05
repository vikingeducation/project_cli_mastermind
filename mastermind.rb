require_relative 'board'
require_relative 'player'

class Mastermind
  # initialize
  def initialize
    # set up the board
    @board = Board.new

    # set up player
    @player = Player.new(@board)
  end

  # play
  def play

    # loop twelve times
    12.times

      # render board
      @board.render

      # ask for user input
      @player.get_input

      # check_victory
      break if check_victory
    end

    # run loser_message
    loser_message
  end

    # loser message
    def loser_message

      # puts out a message
      puts "Too bad, try again"
      # puts out winning combination
      puts "#{@board.winning_combination}"
    end

    # check_victory
    def check_victory

      # a winning_combination?
      if @board.winning_combination?
        # display a victory message
    end