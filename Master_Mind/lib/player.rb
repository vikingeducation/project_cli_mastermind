require './MasterMind'
require './computer'
require './board'

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