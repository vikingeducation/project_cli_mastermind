class MasterMind

  attr_accessor :round, :master_code

  def initialize
    @board = Board.new(self, @code_breaker)
    @computer = Computer.new(self, @board)
    @mode = nil
    @master_code = nil
    @code_breaker = Player.new(self, @board)
    @round = 1
  end

  def ask_for_mode
    puts "Type 'quit' and then enter, at any point, to exit the game."
    puts ""
    print "Press '1' (to play as the Code Breaker) or '2' (as the Code Maker) and then enter, to set the mode: "
    @mode = @code_breaker.set_mode
    puts ""
  end

  def ask_for_master_code
    if @mode == '1'
      @master_code = @computer.make_a_code
    else
      puts "Code Maker, set a code of four pegs from these pegs (!, @, #, $, %, ^, & , *)."
      print "Each peg must be different (e.g. !@#$): "
      @master_code = @code_breaker.make_a_code
    end
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

  def play_game
    @round = 1
    @board.render
    until @board.clue_board[@round - 2] == ['E','E','E','E'] || @round == 13
      @board.pegs = %w[! @ # $ % ^ & *]
      if @mode == '1'
        @code_breaker.play_round
      else
        @computer.play_round(@round)
      end
      @board.render
      @round += 1
    end
    display_outcome
    print @computer.definite
    print @computer.definitely_not
    print @computer.exact_positions
    print @computer.maybe
  end

  def display_outcome
    if @board.clue_board[@round - 2] == ['E','E','E','E']
      puts ""
      puts "YOU WIN!!"
      puts ""
    else
      puts ""
      puts "MASSIVE FAIL!! THE ANSWER IS -#{@master_code.join('-')}-"
      puts ""
      puts "I suggest a diet rich in blueberries and salmon."
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
    @code_breaker = player
    @board = []
    12.times { @board << %w[= = = =] }
    @pegs = %w[! @ # $ % ^ & *]
    @peg_holder = %w[q w e r a s d f]
    @board_position = %w[1 2 3 4]
  end

  def assess_guess
    @clue_board[@mastermind.round-1] = []
    @board[@mastermind.round-1].each_with_index do |peg, index|
      if peg == @mastermind.master_code[index]
        @clue_board[@mastermind.round-1] << 'E'
      elsif @mastermind.master_code.include? peg
        @clue_board[@mastermind.round-1] << "R"
      end
    end
    if @clue_board[@mastermind.round-1].empty?
      @clue_board[@mastermind.round-1] = %w[F A I L !]
    else
      @clue_board[@mastermind.round-1].sort!
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

  def switch_pegs(chosen_key, destination_key)
    round_array = @mastermind.round - 1
    chosen_key_index = find_key_index(chosen_key)
    destination_key_index = find_key_index(destination_key)
    if @peg_holder.include? chosen_key.downcase
      if @peg_holder.include? destination_key.downcase
        @pegs[chosen_key_index], @pegs[destination_key_index] = @pegs[destination_key_index], @pegs[chosen_key_index]
      else
        @pegs[chosen_key_index], @board[round_array][destination_key_index] = @board[round_array][destination_key_index], @pegs[chosen_key_index]
      end
    elsif @peg_holder.include? destination_key.downcase
      @board[round_array][chosen_key_index], @pegs[destination_key_index] = @pegs[destination_key_index], @board[round_array][chosen_key_index]
    else
      @board[round_array][chosen_key_index], @board[round_array][destination_key_index] = @board[round_array][destination_key_index], @board[round_array][chosen_key_index]
    end
  end

  def render
    puts "--------------------------"
    puts ""
    puts "Legend"
    puts "E = exact"
    puts "R = right but in the wrong position"
    puts ""
    puts "   -1-2-3-4- KEYPAD"
    puts "12 -#{@board[11][0]}-#{@board[11][1]}-#{@board[11][2]}-#{@board[11][3]}- #{@clue_board[11].join('')}"
    puts "11 -#{@board[10][0]}-#{@board[10][1]}-#{@board[10][2]}-#{@board[10][3]}- #{@clue_board[10].join('')}"
    puts "10 -#{@board[9][0]}-#{@board[9][1]}-#{@board[9][2]}-#{@board[9][3]}- #{@clue_board[9].join('')}"
    puts "9  -#{@board[8][0]}-#{@board[8][1]}-#{@board[8][2]}-#{@board[8][3]}- #{@clue_board[8].join('')}"
    puts "8  -#{@board[7][0]}-#{@board[7][1]}-#{@board[7][2]}-#{@board[7][3]}- #{@clue_board[7].join('')}"
    puts "7  -#{@board[6][0]}-#{@board[6][1]}-#{@board[6][2]}-#{@board[6][3]}- #{@clue_board[6].join('')}"
    puts "6  -#{@board[5][0]}-#{@board[5][1]}-#{@board[5][2]}-#{@board[5][3]}- #{@clue_board[5].join('')}"
    puts "5  -#{@board[4][0]}-#{@board[4][1]}-#{@board[4][2]}-#{@board[4][3]}- #{@clue_board[4].join('')}"
    puts "4  -#{@board[3][0]}-#{@board[3][1]}-#{@board[3][2]}-#{@board[3][3]}- #{@clue_board[3].join('')}"
    puts "3  -#{@board[2][0]}-#{@board[2][1]}-#{@board[2][2]}-#{@board[2][3]}- #{@clue_board[2].join('')}"
    puts "2  -#{@board[1][0]}-#{@board[1][1]}-#{@board[1][2]}-#{@board[1][3]}- #{@clue_board[1].join('')}"
    puts "1  -#{@board[0][0]}-#{@board[0][1]}-#{@board[0][2]}-#{@board[0][3]}- #{@clue_board[0].join('')}"
    puts "   -1-2-3-4- KEYPAD"
    puts ""
    puts "   -#{@pegs[0]}-#{@pegs[1]}-#{@pegs[2]}-#{@pegs[3]}-"
    puts "   -Q-W-E-R- KEYPAD"
    puts ""
    puts "   -#{@pegs[4]}-#{@pegs[5]}-#{@pegs[6]}-#{@pegs[7]}-"
    puts "   -A-S-D-F- KEYPAD"
    puts ""
  end

end

class Computer

  attr_accessor :definite, :definitely_not
  attr_reader :exact_positions, :maybe

  def initialize(game, board)
    @mastermind = game
    @board = board
    @definite = []
    @definitely_not = []
    @maybe = []
    @exact_positions = {}
  end

  def assess_results(round)
    e_count_current = 0
    e_count_previous = 0
    @board.clue_board[round-1].each { |e| e_count_current += 1 if e == "E"}
    @board.clue_board[round-2].each { |e| e_count_previous += 1 if e == "E"}
    if round >= 2 && round <= 5
      if @board.clue_board[round-1].size > @board.clue_board[round-2].size
        @definite << @board.board[round-1][round-2]
        @definitely_not << @board.pegs[round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      elsif @board.clue_board[round-1].size < @board.clue_board[round-2].size
        @definite << @board.pegs[round-2]
        @definitely_not << @board.board[round-1][round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      elsif @board.clue_board[round-1] == @board.clue_board[round-2]
        # This is going to take some work 
        @maybe << @board.board[round-1][round-2]
        @maybe << @board.pegs[round-2]
      else
        @definite << @board.board[round-1][round-2]
        @definite << @board.pegs[round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      end
    end
    if round > 5 && @maybe.size == 2

    end
  end

  # Dealing with maybes
  # First I guess you'd put all your definites in place.
  # Then you'd put your definites in.
  # Then you'd start subbing in one of the maybes at a time to figure out if it's supposed to be there. 

  def check_for_exacts(round, e_count_previous, e_count_current)
    if e_count_current - e_count_previous == 1
      @exact_positions[@board.board[round-1][round-2]] = round-2
    elsif e_count_previous - e_count_current == 1
      @exact_positions[@board.board[round-2][round-2]] = round-2
    end
  end

  def make_a_code
    pegs = %w[! @ # $ % ^ & *]
    master_code = []
    4.times {master_code << pegs.shuffle!.pop}
    master_code
  end

  def play_round(round)
    pegs = %w[! @ # $ % ^ & *]
    if round == 1
      @board.board[round-1] = %w[! @ # $]
    elsif round < 6
      new_array = @board.board[round-2]
      @board.board[round-1] = new_array.dup
      @board.board[round-1][round - 2] = @board.pegs[round + 2]
    end
    @board.assess_guess
    assess_results(round)
  end

end

class Player

  attr_accessor :response

  def initialize(game, board)
    @mastermind = game
    @response = nil
    @board = board
  end

  def choose_key
    respond
    until key_is_valid?
      print "Invalid selection! Type 'z' to submit your code or enter a KEYPAD position (1, 2, 3, 4, Q, W, E, R, A, S, D, F): "
      respond
    end
    submit if @response.downcase == 'z'
    @response
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
    return true if ['1','2','3','4','q','w','e','r','a','s','d','f','z'].include? @response.downcase
    false
  end

  def make_a_code
    respond
    until code_is_valid?
      puts "The code you have entered is invalid!"
      puts "Code Maker, set a code of four pegs from these pegs (!, @, #, $, %, ^, & , *)."
      print "Each peg must be different (e.g. !@#$): "
      respond
    end
    @response.split('')
  end

  def mode_is_valid?
    if @response == '1' || @response == '2'
      return true
    end
    false
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
    @board.render
  end

  def quit?
    @response == 'quit'
  end

  def respond
    @response = gets.chomp
    exit if quit?
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

end

MasterMind.new.start_game