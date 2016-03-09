class Board
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
  end


  def compare( input, turn )
    check_win( input, turn )
    close_or_exact[turn] = {"near" => 0, "exact" => 0}
    code.each do |key, value|

      if input[key] == value
        close_or_exact[turn]["exact"] += 1
      elsif input.values.include?(value)
        close_or_exact[turn]["near"] += 1
      end
    end
  end

  def check_win( input, turn )

    if code == input
      puts "\n You find the code ! You Win !\n"
      puts " The code was #{code} !\n"
      exit
    elsif turn == 12
      puts "\nThe code was #{code} !"
      puts "\n Well Tried !\n"
    end
  end


  def save_guess( input, turn )
    input.each do |key, value|
      @board_game[turn][key] = value
    end
  end

  def save_code input
    input.each do |k, v|
      code[k] = v
    end
  end

  def make_guess
    computer_guess = {}
    (1..4).each do |i|
      computer_guess[i] = rand(1..6)
    end
    computer_guess
  end
    


  def create_code
    (1..4).each do |i|
      code[i] = rand(1..6)
    end
    puts code
  end

end