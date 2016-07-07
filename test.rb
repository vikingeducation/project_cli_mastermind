
guess_board = Array.new(3){Array.new(2, "1")}
feedback_board = Array.new(3){Array.new(2, "0")}

display_image = []

guess_board.each_with_index {|row, i| display_image[i] = row + feedback_board[i]}

# p display_image
