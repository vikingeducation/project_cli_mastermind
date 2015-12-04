class MasterMind

  attr_accessor :round

  def initialize
    @board = Board.new(self, @code_breaker)
    @computer = Computer.new
    @mode = nil
    @master_code = nil
    @code_breaker = Player.new(self, @board)
    @code_maker = Player.new(self, @board)
    @round = 1
  end

  def ask_for_mode
    puts "Type 'quit' and then enter, at any point, to exit the game."
    puts ""
    print "Press '1' or '2' and then enter, to set the mode: "
    @mode = @code_breaker.set_mode
    puts ""
  end

  def ask_for_master_code
    if @mode == '1'
      @master_code = @computer.make_a_code
    else
      puts "Code Maker, set a code of four numbers from '1' to '8'."
      print "Each number must be different (e.g. 1234): "
      @master_code = @code_maker.make_a_code
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
    puts "ONE player mode:"
    puts "- The computer decides a combination of pegs for the player to guess."
    puts "- The player gets 12 guesses."
    puts "- After every guess the player will be told how accurate their guess was, next to their guess. (%) stands for correct number but wrong position. ($) stands for exact number and position. These will not specify which pegs they're indicating."
    puts "- The game ends when the code is guessed or the player runs out of guesses."
    puts ""
    puts "TWO player mode:"
    puts "- Same as above except player TWO will set the code instead of the computer."
    puts "--------------------------"
    puts ""
    ask_for_mode
    ask_for_master_code
    play_game
  end

  def play_game
    @round = 1
    until @code_breaker.response == @master_code || round == 13
      @board.pegs = %w[! @ # $ % ^ & *]
      @code_breaker.play_round
      @round += 1
    end
  end
end

class Board

  attr_accessor :board, :pegs, :peg_holder, :board_position

  def initialize(game, player)
    @mastermind = game
    @code_breaker = player
    @board = []
    12.times { @board << %w[= = = =] }
    @pegs = %w[! @ # $ % ^ & *]
    @peg_holder = %w[q w e r a s d f]
    @board_position = %w[1 2 3 4]
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
    puts "12 -#{@board[11][0]}-#{@board[11][1]}-#{@board[11][2]}-#{@board[11][3]}-"
    puts "11 -#{@board[10][0]}-#{@board[10][1]}-#{@board[10][2]}-#{@board[10][3]}-"
    puts "10 -#{@board[9][0]}-#{@board[9][1]}-#{@board[9][2]}-#{@board[9][3]}-"
    puts "9  -#{@board[8][0]}-#{@board[8][1]}-#{@board[8][2]}-#{@board[8][3]}-"
    puts "8  -#{@board[7][0]}-#{@board[7][1]}-#{@board[7][2]}-#{@board[7][3]}-"
    puts "7  -#{@board[6][0]}-#{@board[6][1]}-#{@board[6][2]}-#{@board[6][3]}-"
    puts "6  -#{@board[5][0]}-#{@board[5][1]}-#{@board[5][2]}-#{@board[5][3]}-"
    puts "5  -#{@board[4][0]}-#{@board[4][1]}-#{@board[4][2]}-#{@board[4][3]}-"
    puts "4  -#{@board[3][0]}-#{@board[3][1]}-#{@board[3][2]}-#{@board[3][3]}-"
    puts "3  -#{@board[2][0]}-#{@board[2][1]}-#{@board[2][2]}-#{@board[2][3]}-"
    puts "2  -#{@board[1][0]}-#{@board[1][1]}-#{@board[1][2]}-#{@board[1][3]}-"
    puts "1  -#{@board[0][0]}-#{@board[0][1]}-#{@board[0][2]}-#{@board[0][3]}-"
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
  def make_a_code
    numbers = [1,2,3,4,5,6,7,8]
    master_code = []
    4.times {master_code << numbers.shuffle!.pop}
    master_code.join('')
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
    code_numbers = @response.split('')
    if code_numbers.size == 4 && code_numbers.size == code_numbers.uniq.size
      code_numbers.each do |number|
        if !((1..8).include? number.to_i)
          return false
        end
      end
    else
      return false
    end
    true
  end

  def key_is_valid?
    # if @response == 'z' then all of this should until loop with the submit? method as the conditional. we want to see if there's a full code up there we can submit
    # if not we need to prompt them for a new respond, that's gotta keep looping until valid.
    # once that loop ends, it can still goto this return true or false thing.
    return true if ['1','2','3','4','q','w','e','r','a','s','d','f','z'].include? @response.downcase
    false
  end

  def make_a_code
    respond
    until code_is_valid?
      puts "The code you have entered is invalid!"
      puts "Code Maker, set a code of four numbers from 1 to 8."
      print "Each number must be different (e.g. 1234): "
      respond
    end
    @response
  end

  def mode_is_valid?
    if @response == '1' || @response == '2'
      return true
    end
    false
  end

  def play_round
    @board.render
    until false
      print "Select peg to move (via its KEYPAD position) or 'z' and enter to submit code: "
      chosen_peg = choose_key
      break if chosen_peg.downcase == 'z'
      print "Select peg destination (via its KEYPAD position) or 'z' and enter to submit code: "
      peg_destination = choose_key
      break if peg_destination.downcase == 'z'
      @board.switch_pegs(chosen_peg, peg_destination)
      @board.render
    end
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