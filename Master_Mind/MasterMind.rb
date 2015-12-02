class MasterMind
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @computer = Computer.new
    @mode = '2'
    @code = nil
  end

  def fetch_a_code
    if @mode == '1'
      @code = @computer.make_a_code
    else
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
    end
    true
  end

  def make_a_code
    @response = nil
    puts "Code Maker, set a code of four numbers from 1 to 8."
    print "Each number must be different (e.g. 1234): "
    respond
    until code_is_valid?
      puts "The code you have entered is invalid!"
      puts "Code Maker, set a code of four numbers from 1 to 8."
      print "Each number must be different (e.g. 1234): "
      respond
    end
    @response
  end

  def respond
    @response = gets.chomp
    exit if quit?
  end

  def quit?
    @response == 'quit'
  end
end

class Computer

end

MasterMind.new.fetch_a_code