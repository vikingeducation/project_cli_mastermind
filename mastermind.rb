# winning code is set
# repeats until win/lose
# code breaker inputs guess
# gets feedback

require_relative 'listener'
require_relative 'board'
require_relative 'player'
require_relative 'render'

class Game
  def initialize(args = {})
    @board = args[:board]         || Board.new
    @codebreaker = args[:breaker] || HumanPlayer.new
    @codemaker = args[:maker]     || ComputerPlayer.new
    
  end

  def play
    Render.welcome @board.colors
    Render.sequence_instuctions @board.colors
    @board.winning_sequence = @codemaker.get_sequence
    until win? || lose?
      Render.sequence_instuctions @board.colors
      @guess = @codebreaker.get_sequence
      @board.check_guess @guess
    end
  end

  def win?
    @guess == @board.winning_sequence
  end

  def lose?
    @board.turns > 12
  end

end

class Setup

  def initialize(args = {})
    @listener = args[:listener] || Listener.new
    @player1, @player2 = create_players
    start
  end

  def create_players
    num = number_of_players
    if num == 2
      [HumanPlayer.new, HumanPlayer.new]
    else
      [HumanPlayer.new, ComputerPlayer.new]
    end
  end

  def start
    Game.new(set_roles)
  end

  def set_roles
    role = player_one_role
    if role == "maker"
      { maker: player1, breaker: player2 }
    else
      { maker: player2, breaker: player1 }
    end
  end

  def player_one_role
    role = nil
    until valid_role?(role)
      puts "Is player one the maker or breaker?"
      role = listener.get_formatted_input
    end
    role
  end

  def number_of_players
    number_of_players = nil
    until valid_number_of_players?(number_of_players)
      puts "1 or 2 players?"
      number_of_players = listener.get_numeric_input
    end
    number_of_players
  end

  private
    attr_reader :listener, :player1, :player2

    def valid_number_of_players?(number_of_players)
      [1, 2].include?(number_of_players)
    end

    def valid_role?(role)
      ["maker", "breaker"].include?(role)
    end
end

Setup.new