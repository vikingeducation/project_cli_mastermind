# Your code here!
class Hanoi

  def initialize(stack)
    @stack = stack
    @board = []
  end

  def populate
    @board[0]=(1..@stack).to_a.reverse
    @board[1] = []
    @board[2] = [0]
  end

  def get_move
    display
    print "what is your starting location?"
    @origin = gets.chomp.to_i
    print "what is your ending location?"
    @ending = gets.chomp.to_i
  end

  def move
    @board[@ending].push(@board[@origin].pop) if is_valid?
    else
      puts "invalid"
  end


  def is_valid?
    true if @board[@ending].last == nil || @board[@origin].last < @board[@ending].last
    else
      false
  end

  def play
    loop do
      get_move
      break if game_over?
    end

  def display
    @board.each_with_index {|column, num| print "#{num}: #{column}}
  end

  def game_over?
    if @board[1].length == @stack || @board[2].length == @stack
  end

end

puts "what is the stack count?"
stack = gets.chomp.to_i
h=Hanoi.new(stack)
h.populate
h.play