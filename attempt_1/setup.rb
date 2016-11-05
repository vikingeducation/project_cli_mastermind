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
      role = listener.get_formatted
    end
    role
  end

  def number_of_players
    number_of_players = nil
    until valid_number_of_players?(number_of_players)
      puts "1 or 2 players?"
      number_of_players = listener.get_numeric
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