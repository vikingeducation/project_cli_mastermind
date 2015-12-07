class MasterMind

  attr_reader :human, :computer, :mode, :round, :master_code

  def initialize
    @board = Board.new(self, human)
    @computer = Computer.new(self, @board)
    @mode = nil
    @master_code = nil
    @human = Human.new(self, @board)
    @round = 1
  end

  def start_game
    puts ""
    puts ""
    puts "///// - MASTERMIND - \\\\\\\\\\"
    puts "--------------------------"
    puts "By Steven Chang"
    puts "--------------------------"
    puts ""
    puts "Mastermind is a code-breaking game for ONE or TWO players."
    puts ""
    puts "The game is played using:"
    puts ""
    puts "- A decoding board with twelve rows containing four large holes."
    puts "- Code pegs of eight different numbers, which will be placed in the large holes on the board."
    puts ""
    puts "'Code Breaker' mode:"
    puts "- The computer decides a combination of pegs for the player to guess."
    puts "- The player gets 12 guesses."
    puts "- After every guess the player will be told how accurate their guess was, next to their guess. (%) stands for correct number but wrong position. ($) stands for exact number and position. These will not specify which pegs they're indicating."
    puts "- The game ends when the code is guessed or the player runs out of guesses."
    puts ""
    puts "'Code Maker' mode:"
    puts "- Same as above except the player will set the code and the computer will try to break it."
    puts "--------------------------"
    puts ""
    ask_for_mode
    ask_for_master_code
    play_game
  end

  private

  def ask_for_mode
    puts "Type 'quit' and then enter, at any point, to exit the game."
    puts ""
    print "Press '1' (to play as the Code Breaker) or '2' (as the Code Maker) and then enter, to set the mode: "
    @mode = human.set_mode
    puts ""
  end

  def ask_for_master_code
    if mode == '1'
      @master_code = @computer.make_a_code
    else
      puts "Code Maker, set a code of four pegs from these pegs (!, @, #, $, %, ^, & , *)."
      print "Each peg must be different (e.g. !@#$): "
      @master_code = human.make_a_code
    end
  end

  def delegate_player
    if @mode == '1'
      human.play_round
    else
      @computer.play_round
    end
  end

  def play_game
    @board.render
    until @board.correct_answer? || @round == 13
      delegate_player
      @board.refresh_pegs
      @board.render
      @round += 1
    end
    display_outcome
  end

  def display_outcome
    if @mode == "1"
      if @board.correct_answer?
        puts ""
        puts "YOU WIN!!"
        puts ""
      else
        puts ""
        puts "MASSIVE FAIL!! THE ANSWER IS -#{@master_code.join('-')}-"
        puts ""
        puts "I suggest a diet rich in blueberries and salmon."
        puts ""
      end
    else
      if @board.correct_answer?
        puts ""
        puts "COMPUTER WINS!!"
        puts ""
      else
        puts ""
        puts "MAN WINS!!"
        puts ""
      end
    end
  end
end

class Board

  attr_accessor :board, :pegs, :peg_holder, :board_position
  attr_reader :clue_board

  def initialize(game, player)
    @mastermind = game
    @clue_board = []
    12.times { @clue_board << [] }
    @human = player
    @board = []
    12.times { @board << %w[= = = =] }
    @pegs = %w[! @ # $ % ^ & *]
    @peg_holder = %w[q w e r a s d f]
    @board_position = %w[1 2 3 4]
  end

  def assess_guess
    @clue_board[round] = []
    return_clues
    organise_clues
  end

  def correct_answer?
    true if clue_board[round - 1] == ['E','E','E','E']
  end

  def place_definites(wrong_hash, exact_hash)
    remaining_spots = [0,1,2,3]
    if wrong_hash.size != 0
      wrong_hash.each do |key, indexes|
        exact_hash.each do |keyx, value|
          remaining_spots = remaining_spots - [value]
        end
      @board[round][remaining_spots.shuffle!.pop] = key
      end
    end
  end

  def place_exacts(exact_hash)
    exact_hash.each do |key, value|
      @board[round][value] = key
      @pegs.each do |peg|
        if peg == key
          peg = "="
        end
      end
    end
  end

  def refresh_pegs
    @pegs = %w[! @ # $ % ^ & *]
  end

  def render
    puts "--------------------------"
    puts ""
    puts "Legend"
    puts "E = exact"
    puts "R = right but in the wrong position"
    puts ""
    render_board
    render_keypad
  end

  def render_board
    puts "   -1-2-3-4- KEYPAD"
    i = 11
    while i >= 0
      if i + 1 >= 10
        puts "#{i + 1} -#{@board[i][0]}-#{@board[i][1]}-#{@board[i][2]}-#{@board[i][3]}- #{@clue_board[i].join('')}"
      else
        puts "#{i + 1}  -#{@board[i][0]}-#{@board[i][1]}-#{@board[i][2]}-#{@board[i][3]}- #{@clue_board[i].join('')}"
      end
      i -= 1
    end
    puts "   -1-2-3-4- KEYPAD"
  end

  def render_keypad
    puts ""
    puts "   -#{@pegs[0]}-#{@pegs[1]}-#{@pegs[2]}-#{@pegs[3]}-"
    puts "   -Q-W-E-R- KEYPAD"
    puts ""
    puts "   -#{@pegs[4]}-#{@pegs[5]}-#{@pegs[6]}-#{@pegs[7]}-"
    puts "   -A-S-D-F- KEYPAD"
    puts ""
  end

  def switch_pegs(chosen_key, destination_key)
    round_array = round
    chosen_key_index = find_key_index(chosen_key)
    destination_key_index = find_key_index(destination_key)
    if @peg_holder.include? chosen_key
      switch_when_from_peg_holder(destination_key, chosen_key_index, destination_key_index, round_array)
    else
      switch_when_from_board(destination_key, round_array, chosen_key_index, destination_key_index)
    end
  end

  private

  def round
    round = @mastermind.round - 1
  end

  def organise_clues
    if @clue_board[round].empty?
      @clue_board[round] = %w[F A I L !]
    else
      @clue_board[round].sort!
    end
  end

  def return_clues
    @board[round].each_with_index do |peg, index|
      if peg == @mastermind.master_code[index]
        @clue_board[round] << 'E'
      elsif @mastermind.master_code.include? peg
        @clue_board[round] << "R"
      end
    end
  end

  def find_key_index(key)
    if @peg_holder.include? key.downcase
      key_index = @peg_holder.index(key.downcase)
    else
      key_index = @board_position.index(key)
    end
    key_index
  end

  def switch_when_from_peg_holder(destination_key, chosen_key_index, destination_key_index, round_array)
    if @peg_holder.include? destination_key
        @pegs[chosen_key_index], @pegs[destination_key_index] = @pegs[destination_key_index], @pegs[chosen_key_index]
    else
      @pegs[chosen_key_index], @board[round_array][destination_key_index] = @board[round_array][destination_key_index], @pegs[chosen_key_index]
    end
  end

  def switch_when_from_board(destination_key, round_array, chosen_key_index, destination_key_index)
    if @peg_holder.include? destination_key
      @board[round_array][chosen_key_index], @pegs[destination_key_index] = @pegs[destination_key_index], @board[round_array][chosen_key_index]
    else
      @board[round_array][chosen_key_index], @board[round_array][destination_key_index] = @board[round_array][destination_key_index], @board[round_array][chosen_key_index]
    end
  end

end

class Player

  def initialize(game, board)
    @mastermind = game
    @board = board
  end

end

class Computer < Player

  attr_accessor :definite, :definitely_not, :round
  attr_reader :exact_positions, :maybe

  def initialize(game, board)
    super(game, board)
    @definite = []
    @definitely_not = []
    @maybe = []
    @exact_positions = {}
    @wrong_positions = {}
    @e_count_current = 0
    @e_count_previous = 0
  end

  def make_a_code
    pegs = %w[! @ # $ % ^ & *]
    master_code = []
    4.times {master_code << pegs.shuffle!.pop}
    master_code
  end

  def play_round
    pegs = %w[! @ # $ % ^ & *]
    if current_round == 0
      @board.board[current_round] = %w[! @ # $]
    elsif @board.clue_board[previous_round].size == 4
      assess_results # NEED TO LOOK INTO POSITIONING OF THIS
      @definite = @board.board[previous_round]
      @board.place_exacts(@exact_positions)
      @board.place_definites(@wrong_positions, @exact_positions)
    elsif @definite.size == 4
      assess_results #NEED TO LOOK INTO POSITIONING OF THIS
      @board.place_exacts(@exact_positions)
      @board.place_definites(@wrong_positions, @exact_positions)
    elsif current_round < 5
      new_array = @board.board[previous_round]
      @board.board[current_round] = new_array.dup
      @board.board[current_round][previous_round] = @board.pegs[current_round + 3]
    end
    @board.assess_guess
    assess_results # NEED TO LOOK INTO POSITIONING OF THIS
    print @definite
    print @definitely_not
    print @maybe
    print @exact_positions
    print @wrong_positions
  end

  private

  def current_round
    @mastermind.round - 1
  end

  def previous_round
    @mastermind.round - 2
  end

  def add_previous_wrong_positions
    @wrong_positions.each do |key, value|
      @board.board.each do |turn|
        if turn.include? key
          @wrong_positions[key] = (value << turn.index(key)).uniq
        end
      end
    end
  end

  def add_pegs_to_wrong_positions
    @definite.each do |peg|
      if !(@exact_positions.keys.include? peg)
        @wrong_positions[peg] = []
      end
    end
  end

  def add_exact_position_value_to_wrong_positions
    @exact_positions.values.each do |index|
      @wrong_positions.each do |key, value|
        @wrong_positions[key] = (value << index)
      end
    end
  end

  def three_wrongs_make_a_right
    @wrong_positions.each do |key, value|
      if @wrong_positions[key].size == 3
        @exact_positions[key] = [[0,1,2,3] - value][0][0]
        @wrong_positions.delete(key)
      end
    end
  end

  def assess_results
    count_exacts
    if @definite.size == 4
      add_pegs_to_wrong_positions
      add_exact_position_value_to_wrong_positions
      add_previous_wrong_positions
      three_wrongs_make_a_right
    elsif current_round >= 1 && current_round <= 4
      delegate_definites_maybes
      check_for_exacts
    end
  end

  def count_exacts
    @e_count_current = 0
    @e_count_previous = 0
    @board.clue_board[current_round].each { |e| @e_count_current += 1 if e == "E"}
    @board.clue_board[previous_round].each { |e| @e_count_previous += 1 if e == "E"}
  end

  def delegate_definites_maybes
    if @board.clue_board[current_round].size > @board.clue_board[previous_round].size
      @definite << @board.board[current_round][previous_round]
      @definitely_not << @board.pegs[previous_round]
    elsif @board.clue_board[current_round].size < @board.clue_board[previous_round].size
      @definite << @board.pegs[previous_round]
      @definitely_not << @board.board[current_round][previous_round]
    else
      delegate_maybes
    end
  end

  def delegate_maybes
    if @board.clue_board[current_round] == @board.clue_board[previous_round]
      @maybe << @board.board[current_round][previous_round]
      @maybe << @board.pegs[previous_round]
    else
      @definite << @board.board[current_round][previous_round]
      @definite << @board.pegs[previous_round]
    end
  end

  def check_for_exacts
    if @e_count_current - @e_count_previous == 1
      @exact_positions[@board.board[current_round][previous_round]] = previous_round
    elsif @e_count_previous - @e_count_current == 1
      @exact_positions[@board.board[previous_round][previous_round]] = previous_round
    end
  end

end

class Human < Player

  attr_accessor :response

  def initialize(game, board)
    super(game, board)
    @response = nil
  end

  def make_a_code
    respond
    until code_is_valid?
      puts "The code you have entered is invalid!"
      puts "Code Maker, set a code of four pegs from these pegs (!, @, #, $, %, ^, & , *)."
      print "Each peg must be different (e.g. !@#$): "
      respond
    end
    response.split('')
  end

  def play_round
    loop do
      print "Move from (KEYPAD position) or 'z' to submit code: "
      chosen_peg = choose_key
      break if chosen_peg.downcase == 'z'
      print "Move to (KEYPAD position) or 'z' to submit code: "
      peg_destination = choose_key
      break if peg_destination.downcase == 'z'
      @board.switch_pegs(chosen_peg, peg_destination)
      @board.render
    end
    @board.assess_guess
  end

  def set_mode
    respond
    until mode_is_valid?
      puts "The mode you have entered is invalid!"
      print "Press '1' or '2' and then enter, to set the mode: "
      respond
    end
    @response
  end

  private

  def response
    @response.downcase
  end

  def choose_key
    respond
    until key_is_valid?
      print "Invalid selection! Type 'z' to submit your code or enter a KEYPAD position (1, 2, 3, 4, Q, W, E, R, A, S, D, F): "
      respond
    end
    submit if response == 'z'
    response
  end

  def submit
    until !(@board.board[@mastermind.round-1].include? '=')
      puts "Code must have 4 pegs in it!"
      play_round
    end
  end

  def code_is_valid?
    code = @response.split('')
    if code.size == 4 && code.size == code.uniq.size
      code.each do |peg|
        if !((%w(! @ # $ % ^ & *)).include? peg)
          return false
        end
      end
    else
      return false
    end
    true
  end

  def key_is_valid?
    return true if ['1','2','3','4','q','w','e','r','a','s','d','f','z'].include? response
    false
  end

  def mode_is_valid?
    if response == '1' || response == '2'
      return true
    end
    false
  end

  def quit?
    response == 'quit'
  end

  def respond
    @response = gets.chomp
    exit if quit?
  end

end

MasterMind.new.start_game