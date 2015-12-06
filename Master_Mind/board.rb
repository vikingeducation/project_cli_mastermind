require './MasterMind'
require './computer'
require './player'

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