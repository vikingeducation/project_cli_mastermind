require_relative "logic"

class Board
  include Logic
  attr_accessor :code, :close_or_exact

  def initialize
    @board_game = {}
    @code = {}
    @close_or_exact = {}
    create_board
  end


  def create_board
    (1..12).each { |row| @board_game[row] = {1 => 0, 2 => 0, 3 => 0, 4 => 0} }
  end


  def render_board
    puts "*  *  *  *"
    12.downto(1).each do |row|
      @board_game[row].values.each do |value|
        print value.to_s + "  "
      end
      unless close_or_exact[row].nil?
        print " near: #{close_or_exact[row]["near"]}, correct: #{close_or_exact[row]["exact"]}"
      end
      print "\n"
    end
    puts "\n"
  end


  def save( input, turn = nil )
    if turn.nil?
      input.each do |k, v|
        code[k] = v
      end
    else
      input.each do |key, value|
        @board_game[turn][key] = value
      end
    end
  end

end