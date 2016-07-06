module Display

  def render( guess_board, feedback_board )
    display_image = []
    guess_board.each_with_index {|row, i| display_image[i] = row + feedback_board[i]}
    puts
    # loop through data structure
    display_image.each do |row|
        row.each do |cell|
            # display an existing marker if any, else blank
            cell.nil? ? print("-") : print(cell.to_s)
        end
        puts
    end
    puts
  end

end
