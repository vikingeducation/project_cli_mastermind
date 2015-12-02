class MasterMind
  def initialize
    @board = Board.new
    @computer = Computer.new
    @mode = nil
    @master_code = nil
    @code_breaker = Player.new
    @code_maker = Player.new
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
    start_round
  end

  def start_round
    until @code_breaker.response == @master_code
      puts "--------------------------"
      puts ""
      puts "Legend"
      puts "$ = exact"
      puts "% = right but in the wrong position"
      puts ""
      puts "   -Q-W-E-R-"
      puts "12 -X-X-X-X-"
      puts "11 -X-X-X-X-"
      puts "10 -X-X-X-X-"
      puts "9  -X-X-X-X-"
      puts "8  -X-X-X-X-"
      puts "7  -X-X-X-X-"
      puts "6  -X-X-X-X-"
      puts "5  -X-X-X-X-"
      puts "4  -X-X-X-X-"
      puts "3  -X-X-X-X-"
      puts "2  -X-X-X-X-"
      puts "1  -X-X-X-X-"
      puts "   -Q-W-E-R-"
      puts ""
      puts "1-2-3-4-5-6-7-8-PEGS"
      puts "A-S-D-F-G-H-J-K-PEG HOLDER"
      puts ""
      print "Which peg do you want to move (1 to 8): "
      chosen_peg = @code_breaker.choose_peg
      print "Where do you want the peg to go (Q,W,E,R,A,S etc): "
      peg_destination = @code_breaker.choose_destination
      @code_breaker.response = @master_code
    end
  end
end

class Board

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

  def initialize
    @response = nil
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