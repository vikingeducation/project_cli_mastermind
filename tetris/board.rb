class Board

  attr_reader :lines_cleared

  def initialize
    @lines_cleared = 0
    @cells = Array.new(10) { Array.new(24, :space) }
    @current_piece = :block
    draw_piece
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
    blocks = coordinates(:piece)


    blocks.each do |location|

      col_num, row_num = location[0], location[1]
      return if col_num == num_columns - 1

      if @cells[col_num+1][row_num] == :space
        @cells[col_num+1][row_num] = :piece
        @cells[col_num][row_num] = :space
      end
    end
  end

  def move_left
    blocks = coordinates(:piece)

    blocks.sort_by! {|block| block[0]}

    blocks.each do |location|

      col_num, row_num = location[0], location[1]
      return if col_num == 0

      if @cells[col_num-1][row_num] == :space
        @cells[col_num-1][row_num] = :piece
        @cells[col_num][row_num] = :space
      end
    end
  end

  def drop_down

    blocks = coordinates(:piece)

    blocks.sort_by! {|block| block[1]}

    blocks.each do |location|

      col_num, row_num = location[0], location[1]
      p row_num
      return if row_num == 0
      return if @cells[col_num][row_num - 1] == :full

      row_num.downto(0) do |new_row|
        if @cells[col_num][new_row] != :space
          @cells[col_num][new_row+1] = :piece
          @cells[col_num][row_num] = :space
          return
        end
      end

      @cells[col_num][0] = :piece
      @cells[col_num][row_num] = :space

    end

  end


  def coordinates(element)
    list_coordinates = []
    @cells.each_with_index do |column, col_num|
      row_num = column.index(element)
      list_coordinates << [col_num, row_num] if row_num
    end
    list_coordinates
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

    draw_piece if @cells.none? { |column| column.include? (:piece) }
  end

 # gravity: for each cell including piece
 # (starting at the bottom and working up the screen)
 # if there is space below it, move it down by 1
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
  
  



  #NEW PIECE CREATION SECTION
  #TODO: spin off into class?

  # draw a randomly-selected piece;
  #defaults to top of board in a random row
  # 
  def draw_piece(row = num_rows - 1)
    piece = [:single_block,
             :square,
             :bar_horizontal,
             :bar_vertical].sample

    method(piece).call(row)
  end

  def single_block(row)

    column = rand(num_columns)
    @cells[column][row] = :piece
  end

  def square(row)
    left_column = rand(num_columns - 1 )

    @cells[left_column][row] = :piece
    @cells[left_column + 1][row] = :piece
    @cells[left_column][row - 1] = :piece
    @cells[left_column + 1][row - 1] = :piece

  end

  def bar_horizontal(row)
    left_column = rand(num_columns - 4 )

    @cells[left_column][row] = :piece
    @cells[left_column + 1][row] = :piece
    @cells[left_column + 2][row] = :piece
    @cells[left_column + 3][row] = :piece

  end

  def bar_vertical(row)
    left_column = rand(num_columns - 1 )

    @cells[left_column][row] = :piece
    @cells[left_column][row -1] = :piece
    @cells[left_column][row - 2] = :piece
    @cells[left_column][row - 3] = :piece


  end
  
  def num_columns
    @cells.size
  end

  def num_rows
    @cells[0].size
  end
  
  #there are 4 hidden rows above this to stage blocks
  def num_visible_rows
    @cells[0].size-4
  end
  
  def num_visible_columns
    @cells.size
  end

end