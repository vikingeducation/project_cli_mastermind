class Mastermind
  attr_accessor :turn, :player_choice, :codebreaker, :codemaker
  attr_reader :board, :players

  MAX_TURN_COUNT = 12

  def initialize(players)
    @codebreaker = players[:codebreaker]
    @codemaker = players[:codemaker]
    @board = Board.new
    @turn = 1
  end

  def self.start
    begin
      game_type = Gui.breaker_or_maker
      if game_type == 1
        players = {
          codebreaker: HumanPlayer.new(Gui.get_player),
          codemaker: CpuPlayer.new('CPU')
        }
      elsif game_type == 2
        players = {
          codebreaker: CpuPlayer.new('CPU'),
          codemaker: HumanPlayer.new(Gui.get_player)
        }
      end
      Mastermind.new(players).play
    end until game_type == 1 || game_type == 2
  end

  def play
    begin
      Gui.welcome(codebreaker.player_name, codemaker.player_name)
      board.pegs_target = codemaker.pick_code
      begin
        take_turn
        break if game_won?
        increment_turn
      end until game_lost?
    rescue SystemExit, Interrupt
      puts "\nThanks for playing!"
    end
  end

  private

  def take_turn
    puts
    board.render
    Gui.turn_display(turn.to_s)
    board.peg_slots[turn - 1] = codebreaker.choose
    board.generate_assist(turn - 1)
    nil
  end

  def check_turn_limit
    return true if turn > MAX_TURN_COUNT
    false
  end

  def check_answer(peg_row)
    board.pegs_target == peg_row
  end

  def increment_turn
    @turn += 1
  end

  def game_won?
    if check_answer(board.peg_slots[turn - 1])
      Gui.good_game(board.pegs_target.to_s)
      true
    else
      false
    end
  end

  def game_lost?
    if check_turn_limit
      board.render
      Gui.game_over(board.pegs_target.to_s)
      true
    else
      false
    end
  end
end
