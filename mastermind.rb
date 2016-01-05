require_relative 'board'
require_relative 'player'

class Mastermind
  # initialize
  def initialize
    # set up player
    @player = Player.new(name, @board)

    # set up the board
    @board = Board.new

  end

  # play
  def play

    # get name
    get_name

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
      puts "Congratulations, #{@player.name}!"
  end

  # get player's name
  def get_name
    puts "Please enter your name: "
    @player.name = gets.chomp
  end
end