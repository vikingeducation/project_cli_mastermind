class MasterMind
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @computer = Computer.new
    @mode = nil
    @master_code = nil
  end

  def ask_for_mode
    puts "Type 'quit' and then enter, at any point, to exit the game."
    puts ""
    puts "Press '1' or '2' and then enter, to set the mode: "
    @mode = @player1.set_mode
    puts ""
  end

  def ask_for_master_code
    if @mode == '1'
      @master_code = @computer.make_a_code
    else
      puts "Code Maker, set a code of four numbers from '1' to '8'."
      print "Each number must be different (e.g. 1234): "
      @master_code = @player2.make_a_code
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
  end
end

class Player

  def initialize
    @response = nil
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

class Computer
  def make_a_code
    numbers = [1,2,3,4,5,6,7,8]
    master_code = []
    4.times {master_code << numbers.shuffle!.pop}
    master_code.join('')
  end
end

MasterMind.new.start_game