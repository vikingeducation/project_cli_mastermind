# Your code here!

require 'yaml'
require 'io/wait' #nonblocking i/o

module Tetris

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
    @scores = YAML.load(File.read("highscores.yaml"))
  end

  def start
    print_scores
    @player.welcome
    difficulty = @player.difficulty
    play
  end

  private

  def play
    loop do
      @board.render

      break if @board.swamped?

      sleep amount_set_by_difficulty

      @player.move

      #TODO: later, if nonblocking realtime, consider waiting a period of time here?
    end
    @board.render

    game_over
  end

  def game_over

    puts "Thanks for playing M-TRIS!"
    puts "Good job! Your score was #{my_score}!"

    if top_ten.any? {|entry| my_score > entry[1] }
      save_score
    end
  end

  def print_scores
    puts "WELCOME TO M-TRIS"
    puts "Top Ten Scores"

    0.upto(9) { |i| puts "#{i+1}\) #{top_ten[i][0]}\       #{top_ten[i][1]}\n" }
    puts "Press ENTER to see instructions and continue."
    gets
  end

  def my_score
    @board.lines_cleared * @player.difficulty
  end

  def save_score
    puts "WOW! You're in the high scores now!"
    print "Enter your name for posterity: "
    name = gets.chomp

    @scores << [name, my_score]
    File.open("highscores.yaml", 'w') { |file| file.write(YAML::dump(@scores)) }

    puts "Thanks, #{name}! Your score of #{my_score} will go down in history!"
  end

  #returns scores sorted top score to lowest
  def sorted_scores

    @scores.sort_by {|entry| -1 * entry[1] }
  end

  def top_ten
    sorted_scores[0..9]
  end

  #the number of seconds delay between turns
  def amount_set_by_difficulty
    1 - (Math::log10(@player.difficulty))
  end
end

class Player
  
  attr_reader :difficulty

  def initialize(board)
    @board = board
    @difficulty = 1
  end

  def welcome
    puts `clear`
    puts "WELCOME TO M-TRIS\n\n"
    puts "This is Michael Alexander's block-based puzzle game clone."
    puts "Currently, controls are not totally in realtime."
    puts "A to move left, D for right, S to drop the piece to the bottom."
    puts "No need to press Enter for these."
    puts "Your score will be DIFFICULTY x NUMBER OF ROWS CLEARED"
    puts "*" * 15
    gets
    set_difficulty
  end

  #prompt for move, send to Board
  def move
    direction = char_if_pressed
    @board.move(direction) if direction
  end



  def char_if_pressed
    begin
      state = `stty -g` #turn raw input on
      system `stty raw -echo -icanon isig`
      c = nil
      if $stdin.ready?
        c = $stdin.getc
      end
      c.chr if c
    ensure
      system  `stty #{state}` # turn raw input off
    end
  end


  private

  def set_difficulty
    puts "Enter your difficulty level (1-10): "
    input = gets.chomp.to_i

    @difficulty = input if input.between?(1,10)
  end

  #nonblocking version!!
  def char_if_pressed
    begin
      state = `stty -g` #turn raw input on
      `stty raw -echo -icanon isig`
      c = nil
      if $stdin.ready?  #nonblocking input check here
        c = $stdin.getc
      end
      c.chr if c
    ensure
      system  `stty #{state}` # turn raw input off
    end
  end

  #works on OSX and Linux not Windows
  #gets a char without pressing enter
  def enterless_input
    begin
      state = `stty -g`
      `stty raw -echo -icanon isig`

      input = STDIN.getc.chr
    ensure
      `stty #{state}`
    end
    input
  end




end

class Board

  attr_reader :lines_cleared

  def initialize
    @lines_cleared = 0
    @cells = Array.new(10) { Array.new(22, :space) }
    new_piece
  end

  # public method that leads to the objects getting displayed for 
  # this turn. combines the calculations for movement and actually
  # displaying the pieces
  
  def render

    clear_full_rows
    run_gravity
    check_landings

    display

  end

  # game end condition. returns true if a full cell is ever found
  # on the top visible row
  def swamped?
    (0..num_columns-1).each do |column|
      return true if @cells[column][num_visible_rows - 1] == :full
    end
    false
  end

  def move(direction)
    case direction
    when "a"
      move_left
    when "d"
      move_right
    when "s"
      drop_down
    end
    display
  end

  private
  
  def move_left
    col_num, row_num = coordinates(:piece)
    return if col_num == 0

    if @cells[col_num-1][row_num] == :space
      @cells[col_num-1][row_num] = :piece
      @cells[col_num][row_num] = :space
    end
  end

  def move_right
    col_num, row_num = coordinates(:piece)
    return if col_num == num_columns - 1

    if @cells[col_num+1][row_num] == :space
      @cells[col_num+1][row_num] = :piece
      @cells[col_num][row_num] = :space
    end
  end

  def drop_down
    col_num, row_num = coordinates(:piece)

    return if row_num == 0
    return if @cells[col_num][row_num - 1] == :full

    row_num.downto(0) do |new_row|
      if @cells[col_num][new_row] == :full
        @cells[col_num][new_row+1] = :piece
        @cells[col_num][row_num] = :space
        return
      end
    end

    @cells[col_num][0] = :piece
    @cells[col_num][row_num] = :space

  end


  def coordinates(element)
    @cells.each_with_index do |column, col_num|
      row_num = column.index(element)
      return col_num, row_num if row_num
    end
    nil
  end




  #convenience method for Unicode of a box character
  def box
    "\u25a1".encode('utf-8')
  end
  

  # displays the board right now with piece in right place
  # displays only the bottom 20 rows of pieces because 
  # the top two are meant to be hidden, like real tetrises
  def display
    puts `clear`

    (num_visible_rows-1).downto(0) do |row|
      print "#{row}".ljust(4) + "\|"
      0.upto(num_columns-1) do |column|
        print convert_to_visible(@cells[column][row])
      end
      puts "\|\n"
    end
    puts "===================="
  end
  
  def convert_to_visible(cell)
    case cell
      when :space
        " "
      when :piece
        "M"
      when :full
        box
      end
  end


  def clear_full_rows

    #check each row top to bottom
    num_visible_rows.downto(0) do |row|

      #for each row, check if it's full
      row_full = true
      0.upto(num_columns-1) do |column|
        unless @cells[column][row] == :full
          row_full = false
        end
      end

      next unless row_full
      #if so, clear the whole row
      0.upto(num_columns-1) do |column|
        @cells[column][row] = :space
      end


      @lines_cleared += 1



    end

  end


 # gravity: for each cell including piece
 # (starting at the bottom and working up the screen)
 # if there is space below it, move it down by 1

  #if piece has landed on a :full cell
  #freeze piece as :full cell
  #create new piece way up high
  def check_landings

    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        if row_num == 0 && cell == :piece
          @cells[col_num][row_num] = :full
        elsif row_num == 0
          next
        elsif cell == :piece && @cells[col_num][row_num-1] == :full
          @cells[col_num][row_num] = :full
        end

      end
    end

    new_piece if @cells.none? { |column| column.include? (:piece) }
  end

  def run_gravity

    @cells.each_with_index do |column, col_num|
      column.each_with_index do |this_cell, row_num|
        next if row_num == 0
        if @cells[col_num][row_num-1] == :space
          @cells[col_num][row_num-1] = this_cell
          @cells[col_num][row_num] = :space
        end

      end
    end

  end
  
  

  # create new single-block piece at top of board in a random row
  def new_piece
    column = rand(num_columns)
    
    @cells[column][num_rows - 1] = :piece
  end
  
  def num_columns
    @cells.size
  end

  def num_rows
    @cells[0].size
  end
  
    
  def num_visible_rows
    @cells[0].size-2
  end
  
  def num_visible_columns
    @cells.size
  end

end


end

include Tetris
g = Game.new
g.start