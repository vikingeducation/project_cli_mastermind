class Board
  attr_accessor :combination, :correct_or_not
  def initialize
    @board_game = {}
    @combination = {}
    @correct_or_not = {}
    random_combination
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
      unless correct_or_not[row].nil?
        print " near: #{correct_or_not[row]["near"]}, correct: #{correct_or_not[row]["exact"]}"
      end
      print "\n"
    end
  end


  def compare( input, turn )
    check_win input
    correct_or_not[turn] = {"near" => 0, "exact" => 0}
    combination.each do |key, value|

      if input[key] == value
        correct_or_not[turn]["exact"] += 1
      elsif input.values.include?(value)
        correct_or_not[turn]["near"] += 1
      end
    end
  end

  def check_win input
    if combination == input
      puts "\n You find the combination ! You Win !\n"
      puts " The combination was #{combination} !\n"
      exit
    end
  end


  def save_in_board( input, turn )
    input.each do |key, value|
      @board_game[turn][key] = value
    end
  end


  def random_combination
    (1..4).each do |i|
      combination[i] = rand(1..6)
    end
    puts combination
  end

end