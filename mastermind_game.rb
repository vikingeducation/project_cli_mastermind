class Mastermind
  attr_accessor :turn, :player_choice
  attr_reader :board, :player

  MAX_TURN_COUNT = 12

  def initialize(player)
    @player = player
    @board = Board.new
    @turn = 1
    @player_choice = []
  end

  def play
    Gui.welcome(player.player_name)
    board.generate_target(player.player_name)
    # TEMP CHECK
    puts
    begin
      loop do
        puts
        board.render
        Gui.turn_display(@turn.to_s)
        self.player_choice = player.choose
        break if board.validate_choice(player_choice)
      end
      board.peg_slots[@turn - 1] = player_choice
      board.generate_assist(@turn - 1)
      break if game_won?

      increment_turn
    end until game_lost?
  end

  def check_turn_limit
    return true if @turn > MAX_TURN_COUNT
    false
  end

  def check_answer(peg_row)
    board.pegs_target == peg_row
  end

  def increment_turn
    @turn += 1
  end

  def game_won?
    if check_answer(board.peg_slots[@turn - 1])
      Gui.good_game(board.pegs_target.to_s)
      true
    else
      false
    end
  end

  def game_lost?
    if check_turn_limit
      Gui.game_over(board.pegs_target.to_s)
      true
    else
      false
    end
  end

  def self.Start
    begin
      game_type = Gui.breaker_or_maker
      if game_type == 1
        Mastermind.new(HumanPlayer.new(Gui.get_player)).play
      elsif game_type == 2
        Mastermind.new(CpuPlayer.new("CPU")).play
      end
    end until game_type == 1 || game_type == 2
  end
end
