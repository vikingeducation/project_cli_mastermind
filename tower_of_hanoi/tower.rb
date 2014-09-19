class Hanoi

  def initialize(stack)
    @turn = 0
    @board = []
    @board[0] = (1..stack).to_a.reverse
    @board[1] = []
    @board[2] = []
    @stack = stack
  end


  def play
    puts "The object of the game, as you know, is to take your stack of discs from one tower to another and preserve ordering. In this CLI, the discs are represented by numbers, with larger numbers representing larger discs. The CLI will prompt you to input the tower from which you would like to draw the topmost (right-most) disc, and the tower you will deposit that disc. When providing input, stick to single digit numbers, i.e. /'1/' for Tower 1. Note: it is invalid to place a larger disc (number) on top (to the right of) a smaller disc (number), and it is also invalid to specify an empty tower as your origin. Other than that, enjoy."
    loop do 
      render
      if won?
        puts "You won!!!!!!!!!!"
        break
      else
        get_move
          if is_valid?(@from_tower, @to_tower)
            move(@from_tower, @to_tower)
          else
            puts "that is not a valid move. Try again"
          end
      end
    end
  end

    def won?
    if ((@board[1].length == @stack) || (@board[2].length == @stack))
      true
    else
      false
    end
    end

  def get_move
    puts "From which tower would you like to draw your piece?"
    start = gets.chomp.to_i
    puts "To which tower would you like to place your piece?"
    finish = gets.chomp.to_i
    @from_tower = start-1
    @to_tower = finish-1
  end

  def move(from, to)
       @board[to].push(@board[from].pop)
  end

  def render
    p "Tower 1 #{@board[0]}"
    p "Tower 2 #{@board[1]}"
    p "Tower 3 #{@board[2]}"
  end

  def is_valid?(from, to)
    if @board[from].last == nil
      false
    else
      if @board[to].last == nil || @board[to].last > @board[from].last
        true
      else
        false
      end
    end
  end

end

puts "Have you played the Towers of Hanoi? It's that one game with the three towers and the discs that you move around...Google it. Anyway, let's play a bit using this CLI. Start by typing the number (as an integer! no funny business typing in Hanoi-ese...) of discs you want to play with"

discs = gets.chomp.to_i

game = Hanoi.new(discs)
game.play