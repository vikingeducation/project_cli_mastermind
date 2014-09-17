# Your code here!

module TowerOfHanoi



# in charge of flow control through the turn structure
class Game

  attr_accessor :player, :board

  def initialize
    @player = Player.new
  end

  def play

    player.welcome

    loop do
      player.take_turn
      p game_over?
      break if game_over?
    end

    player.goodbye
  end

  private

  def game_over?
    return true if quit?
    return true if won?
    false
  end

  def quit?
    player.quit?
  end

  def won?
    player.won?
  end


end #class over

#in charge of interface with the user
class Player


  def initialize
    @board = Board.new
    @move = nil
  end

  def welcome
    choose_height
    puts "Instructions:"
    puts "Enter where you'd like to move from and to"
    puts "in the format [1,3]. Enter 'q' to quit."
  end

  def take_turn

    until validate_move
      @board.display
      get_move
    end
    
    @board.make_move(@move) unless quit?
  end

  def goodbye
    puts "Thanks for playing!"
  end

  def quit?
    @move == "Q" || @move == "q"
  end

  def won?
    @board.victory?
  end

  private
  
  def choose_height
    puts "Choose the height of your tower (3-8): "
    height = gets.chomp.to-i
    @board.height = height
  end

  def get_move
    print "Please input your move: "
    input = gets.chomp

    @move = parse(input)

  end

  def validate_move
    @board.validate(@move)
  end

  def parse(input)
    moves = input[1..-1]
    first, second = moves.split(/,/)
    @move = [first.to_i, second.to_i]
  end

end

#in charge of keeping track of pieces (and thus, moves)
class Board

  def initialize
    @stacks = []
    @height = nil
  end

  def height=(height)
    raise "The towers must be between 3 and 8 disks high." unless (3..8) === height
    @height = height
    build(height)
  end

  def display
    puts "Current Board: \n\n"
    tallest.downto(0) { |level| print_level(level) }
    print_labels
  end

  def validate(move)
    return false unless move
    start, finish = move[0] - 1, move[1] - 1
    return false if @stacks[start].empty?
    return false unless (0..2) === start
    return false unless (0..2) === finish


    if @stacks[finish][-1]
      return false unless @stacks[finish][-1].length < @stacks[start][-1].length
    end

    true
  end

  def make_move(move)
    start, finish = move[0]-1, move[1]-1
    @stacks[finish].push(@stacks[start].pop)
  end

  def victory?
    (1..2).each do |stack|
      next unless @stacks[stack].size == @height
      @stacks[stack].each_with_index do |disk, level|
        return false unless disk == disk_of_size(@height-level)
      end
    end
    false
  end

  private

  def print_level(level)
    (0..2).each do |stack|
      if @stacks[stack][level]
        print @stacks[stack][level].ljust(spacing) 
      else
        print "".ljust(spacing)
      end
      puts "\n"
    end
  end

  def print_labels
    ("1".."3").each { |label| print label.ljust(spacing) }
    puts "\n"
  end

  def max_width
    @height
  end

  def tallest
    @height - 1
  end

  def spacing
    max_width + 2
  end

  def build(height)
    0.upto(height-1) do |level|
      @stacks[0] << disk_of_size(height-level)
    end
    @stacks
  end

  def disk_of_size(size)
    "o" * size
  end

end #class Board


end #module

include TowerOfHanoi

g = Game.new
g.play
