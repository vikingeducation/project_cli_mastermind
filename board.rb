class Board
  attr_accessor :combination
  def initialize
    @board_game = {}
    @combination = {}
    random_combination
    create_board
  end

  def create_board
    (1..12).each { |row| @board_game[row] = {1 => 0, 2 => 0, 3 => 0, 4 => 0} }
  end


  def render_board
    4.downto(1) do |row|
      @board_game.each do |k, v|
        if k >= 10
          print v[row].to_s + "   "
        else
          print v[row].to_s + "  "
        end
      end
      print "  *\n"
    end
    @board_game.keys.each { |key| print key.to_s + "  "}
    print "  C\n"
  end


  def compare input
    check_win input

    combination.each do |key, value|

      if input[key] == value
        puts "It's right"
      elsif input.values.include?(value)
        puts "Nearly right"
      else

        puts "didnt do it"
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
    i = 4
    input.values.each do |value|
      @board_game[turn][i] = value
      i -= 1
    end
  end


  def random_combination
    (1..4).each do |i|
      combination[i] = rand(1..6)
    end
    puts combination
  end

end