class MasterMind
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @computer = Computer.new
    @mode = nil
    @code = nil
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
      @code = @computer.make_a_code
    else
      puts "Code Maker, set a code of four numbers from '1' to '8'."
      print "Each number must be different (e.g. 1234): "
      @code = @player2.make_a_code
    end
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

end

MasterMind.new.ask_for_mode