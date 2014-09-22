class Board

  require 'byebug'
  attr_reader :lines_cleared

  def initialize
    @lines_cleared = 0
    @cells = Array.new(10) { Array.new( 24, :space ) }
    @current_piece = :block
    create_piece
  end

  # public method that leads to the objects getting displayed for
  # this turn. combines the calculations for movement and actually
  # displaying the pieces

  def render

    clear_full_rows
    run_gravity

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
    when "w"
      rotate_piece
    end
    display
  end

  private
  
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

    old_blocks = coordinates(:piece)
    #location[0] is col_num, #location[1] is row_num
    #loop through all pieces. map all their coordinates right by one
    new_blocks = old_blocks.map { |location| [location[0]-1, location[1]] }

    if can_draw?(new_blocks)
      clear_all_pieces
      draw_piece(new_blocks)
    end

    if piece_has_landed?
      freeze_all_pieces
      create_piece
    end

  end

  def rotate_piece

    old_blocks = coordinates(:piece)

    col_coordinates = old_blocks.map {|block| block[0]}
    row_coordinates = old_blocks.map {|block| block[1]}

    #get minimum and maximum col_num, row_num
    #add min_col + max_col, divide by 2, add 1 => avg_col
    #add min_row + max_row, divide by 2, add 1 => avg_row

    #pivot_col = col_coordinates.inject(:+)/col_coordinates.length
    #pivot_row = row_coordinates.inject(:+)/row_coordinates.length

    pivot_col = col_coordinates.min
    pivot_row = row_coordinates.max
    #for each coordinate pair of old_blocks, 
    #subtract [avg_col, avg_row] to create an array of 
    #RELATIVE coordinates for each piece around an artificial
    #center of gravity

    block_height = 4
    

    # x2 = (y1 + px - py)
    # y2 = (px + py - x1 - q)

    relative_blocks = old_blocks.map do |block|
      [block[0]-pivot_col, block[1]-pivot_row]
    end
    

    #use rotation formulas to find relative rotation positions for these blocks
    rotated = relative_blocks.map do |block|
      [block[1]+1, -block[0]+1]
    end

    #now, add these changes back to the original coordinates, pair by pair
    #to produce new_blocks
    new_blocks = []

    0.upto(old_blocks.length-1) do |index|
      new_blocks << [pivot_col+rotated[index][0], pivot_row+rotated[index][1]]
    end


    #FINALLY, do the normal can_draw test

    if can_draw?(new_blocks)
      clear_all_pieces
      draw_piece(new_blocks)
    end

    if piece_has_landed?
      freeze_all_pieces
      create_piece
    end

  end


  def move_right

    old_blocks = coordinates(:piece)
    #location[0] is col_num, #location[1] is row_num
    #loop through all pieces. map all their coordinates right by one
    new_blocks = old_blocks.map { |location| [location[0]+1, location[1]] }

    if can_draw?(new_blocks)
      clear_all_pieces
      draw_piece(new_blocks)
    end

    if piece_has_landed?
      freeze_all_pieces
      create_piece
    end

  end

  

 #not working for this version of pieces currently. 
 #TODO: rewrite
  def drop_down

    old_blocks = coordinates(:piece)
    #location[0] is col_num, #location[1] is row_num
    #loop through all pieces. map all their coordinates right by one

    drop_distance = 0

    0.upto(num_rows-1) do |distance|
      new_blocks = old_blocks.map { |location| [location[0], location[1]-distance] }

      break unless can_draw?(new_blocks)
      drop_distance = distance
    end

    new_blocks = old_blocks.map { |location| [location[0], location[1]-drop_distance] }
    clear_all_pieces
    draw_piece(new_blocks)
    freeze_all_pieces
    create_piece
  end
    # OLD DROP_DOWN
    # blocks = coordinates(:piece)

    # blocks.sort_by! {|block| block[1]}

    # blocks.each do |location|

    #   col_num, row_num = location[0], location[1]
    #   p row_num
    #   return if row_num == 0
    #   return if @cells[col_num][row_num - 1] == :full

    #   row_num.downto(0) do |new_row|
    #     if @cells[col_num][new_row] != :space
    #       @cells[col_num][new_row+1] = :piece
    #       @cells[col_num][row_num] = :space
    #       return
    #     end
    #   end

    #   @cells[col_num][0] = :piece
    #   @cells[col_num][row_num] = :space

    # end



  def coordinates(element)
    list_coordinates = []
    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        list_coordinates << [col_num, row_num] if cell == element
      end
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

      display

      row.upto(num_visible_rows) do |row_num|
        0.upto(num_columns-1) do |col_num|
          @cells[col_num][row_num] = @cells[col_num][row_num + 1]
        end
      end


      #column.each_with_index do |this_cell, row_num|
      # @cells.each_with_index do |column, col_num|
      #     next if row_num == 0
      #     if @cells[col_num][row_num-1] == :space
      #       @cells[col_num][row_num-1] = this_cell
      #       @cells[col_num][row_num] = :space
      #     end

      #   end
      # end


    end

  end



  #if piece has landed on a :full cell
  #freeze piece as :full cell
  #create new piece way up high
  def check_landings

    #new_check_landings: search the whole matrix
    #set a true value if any piece is above a full
    # if so, freeze all :pieces


    # piece_has_landed = false
    # @cells.each_with_index do |column, col_num|
    #   column.each_with_index do |cell, row_num|
    #     if row_num == 0 && cell == :piece
    #       landed = true
    #     elsif cell == :piece && @cells[col_num][row_num-1] == :full
    #       landed = true
    #     end
    #   end
    # end

    # if piece_has_landed?
    #   freeze_all_pieces
    #   create_piece
    # end
  end


  def piece_has_landed?
    landed = false
    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        if row_num == 0 && cell == :piece
          landed = true
        elsif cell == :piece && @cells[col_num][row_num-1] == :full
          landed = true
        end
      end
    end
    landed
  end


 # gravity: delete the piece and redraw it one step down if possible
 # if not possible, freezes the piece as a :full
 # implementation detail: uses the top left corner of said piece
 # as anchor

  def run_gravity
    old_blocks = coordinates(:piece)
    #handle bottom blocks first, sorting by row
    old_blocks.sort_by! {|block| block[1]}
    p old_blocks
    #location[0] is col_num, #location[1] is row_num
    #loop through all pieces. map all their coordinates down by one
    new_blocks = old_blocks.map { |location| [location[0], location[1] - 1] }
    p new_blocks
    if can_draw?(new_blocks)
      clear_all_pieces
      draw_piece(new_blocks)
    end

    if piece_has_landed?
      freeze_all_pieces
      create_piece
    end

  end

  # takes array of coordinates in form [[col_num_a, row_num_a],
  # [col_num_b, row_num_b], ...etc]
  # returns true if no :full blocks are already in those spaces
  # returns false if any block is outside of the range of cells
  def can_draw?(blocks)
    return false unless blocks.all? do |block|
      col_num, row_num = block[0], block[1]
      col_num.between?(0, num_columns-1) && row_num.between?(0, num_rows-1)
    end

    blocks.none? {|block| @cells[block[0]][block[1]] == :full }
  end


  # clears the board @cells at each of those coordinates to :space
  def clear_all_pieces

    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        @cells[col_num][row_num] = :space if @cells[col_num][row_num] == :piece
      end
    end
  end  

  # freeze all :pieces into :full
  def freeze_all_pieces

    @cells.each_with_index do |column, col_num|
      column.each_with_index do |cell, row_num|
        @cells[col_num][row_num] = :full if @cells[col_num][row_num] == :piece
      end
    end
  end

  def draw_piece(blocks)
    blocks.each { |block| @cells[block[0]][block[1]] = :piece }
  end


  #def gravity (old)
    # @cells.each_with_index do |column, col_num|
    #   column.each_with_index do |this_cell, row_num|
    #     next if row_num == 0
    #     if @cells[col_num][row_num-1] == :space
    #       @cells[col_num][row_num-1] = this_cell
    #       @cells[col_num][row_num] = :space
    #     end

    #   end
    # end

  #end
  



  #NEW PIECE CREATION SECTION
  #TODO: spin off into class?

  # draw a randomly-selected piece;
  #defaults to top of board in a random row
  # 
  def create_piece(row = num_rows - 1)
    piece = [:square,
             :bar,
             :left_l,
             :right_l,
             :left_s,
             :right_s].sample

    method(piece).call(row)
    rand(4).times {rotate_piece}
  end

  def square(row)
    left_column = rand(num_columns - 1 )

    @cells[left_column][row] = :piece
    @cells[left_column + 1][row] = :piece
    @cells[left_column][row - 1] = :piece
    @cells[left_column + 1][row - 1] = :piece

  end

  def bar(row)
    left_column = rand(num_columns - 4 )

    @cells[left_column][row] = :piece
    @cells[left_column + 1][row] = :piece
    @cells[left_column + 2][row] = :piece
    @cells[left_column + 3][row] = :piece

  end
  
  def right_l(row)
    left_column = rand(num_columns - 2)
    @cells[left_column][row] = :piece
    @cells[left_column][row-1] = :piece
    @cells[left_column][row-2] = :piece
    @cells[left_column+1][row] = :piece
  end

  def left_l(row)
    left_column = rand(num_columns - 2)
    @cells[left_column][row] = :piece
    @cells[left_column+1][row] = :piece
    @cells[left_column+1][row-1] = :piece
    @cells[left_column+1][row-2] = :piece
  end

  def right_s(row)
    left_column = rand(num_columns - 3)
    @cells[left_column][row-1] = :piece
    @cells[left_column+1][row-1] = :piece
    @cells[left_column+1][row] = :piece
    @cells[left_column+2][row] = :piece
  end

  def left_s(row)
    left_column = rand(num_columns - 3)
    @cells[left_column][row] = :piece
    @cells[left_column+1][row] = :piece
    @cells[left_column+1][row-1] = :piece
    @cells[left_column+2][row-1] = :piece
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