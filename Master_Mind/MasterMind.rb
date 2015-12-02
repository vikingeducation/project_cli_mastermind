class MasterMind

  attr_reader :round

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
      @board.pegs = %w[1 2 3 4 5 6 7 8]
      @code_breaker.play_round
      @code_breaker.response = @master_code
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
    12.times { @board << %w[X X X X] }
    @pegs = %w[1 2 3 4 5 6 7 8]
    @peg_holder = %w[a s d f g h j k]
    @board_position = %w[q w e r]
  end

  def render
    puts "--------------------------"
    puts ""
    puts "Legend"
    puts "$ = exact"
    puts "% = right but in the wrong position"
    puts ""
    puts "   -Q-W-E-R-"
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
    puts "   -Q-W-E-R-"
    puts ""
    puts "#{@pegs[0]}-#{@pegs[1]}-#{@pegs[2]}-#{@pegs[3]}-#{@pegs[4]}-#{@pegs[5]}-#{@pegs[6]}-#{@pegs[7]}-PEGS"
    puts "A-S-D-F-G-H-J-K-PEG HOLDER"
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

  def choose_destination
    respond
    until destination_is_valid?
      print "Invalid selection! Enter a position on the board (Q, W, E or R) or a position on the peg holder (A, S, D, F, G, H, J, K): "
      respond
    end
    @response
  end

  def choose_peg
    respond
    until peg_is_valid?
      print "Invalid selection! Enter the number of the peg you want to move (1 to 8): "
      respond
    end
    @response
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

  def destination_is_valid?
    return true if ['q','w','e','r','a','s','d','f','g','h','j','k','l'].include? @response.downcase
    false
  end

  def submit_guess?(board_for_the_round)
    if !((board_for_the_round).include? 'X')
      print "Type 's' then enter to submit your answer: "
      respond
      if @response.downcase == 's'
        return true
      end
    end
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

  def peg_is_valid?
    return true if (1..8).include? @response.to_i
    false
  end

  def play_round
    @board.render
    until submit_guess?(@board.board[@mastermind.round-1])
      print "Which peg do you want to move (1 to 8): "
      chosen_peg = choose_peg
      print "Where do you want the peg to go (Q,W,E,R,A,S etc): "
      peg_destination = choose_destination
      if (@board.pegs.include? chosen_peg) && (@board.peg_holder.include? peg_destination.downcase)
        @board.pegs[@board.pegs.index(chosen_peg)], @board.pegs[@board.peg_holder.index(peg_destination.downcase)] = @board.pegs[@board.peg_holder.index(peg_destination.downcase)], @board.pegs[@board.pegs.index(chosen_peg)]
      elsif (@board.pegs.include? chosen_peg) && (@board.board_position.include? peg_destination.downcase)
        @board.pegs[@board.pegs.index(chosen_peg)], @board.board[@mastermind.round-1][@board.board_position.index(peg_destination.downcase)] = @board.board[@mastermind.round-1][@board.board_position.index(peg_destination.downcase)], @board.pegs[@board.pegs.index(chosen_peg)]
      elsif (@board.board[@mastermind.round-1].include? chosen_peg) && (@board.peg_holder.include? peg_destination.downcase)
        @board.board[@mastermind.round-1][@board.board[@mastermind.round-1].index(chosen_peg)], @board.pegs[@board.peg_holder.index(peg_destination.downcase)] = @board.pegs[@board.peg_holder.index(peg_destination.downcase)], @board.board[@mastermind.round-1][@board.board[@mastermind.round-1].index(chosen_peg)]
      else
        @board.board[@mastermind.round-1][@board.board[@mastermind.round-1].index(chosen_peg)], @board.board[@mastermind.round-1][@board.board_position.index(peg_destination.downcase)] = @board.board[@mastermind.round-1][@board.board_position.index(peg_destination.downcase)], @board.board[@mastermind.round-1][@board.board[@mastermind.round-1].index(chosen_peg)]
      end
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