class Board

  attr_accessor :board

  def initialize
   @board = Array.new
   @exact_matches = {blue: 0, red: 0}
   @total_close_matches = 0
  end

# render_board should just print board
  def render_board
    puts
    @board.each do |arr|
      p arr
    end
    puts
  end

  # check each user_guess index against hidden_code indexes for exact matches
  # exact matches being user_guess[index] == hidden-code[index] returns "black"
  # store in exact = {blue => number of matches, red => number of matches}
  def find_exact_matches(user_guess, hidden_code)
    user_guess.each_with_index do |item, index|
      if item == "blue" && item == hidden_code[index]
        @exact_matches[:blue] += 1
      elsif item == "red" && item == hidden_code[index]
        @exact_matches[:red] += 1
      end
    end
    @exact_matches
  end


   # find close matches check user_guess blue against how many hidden_code blue and then subtract exact blue matches
   # find close matches check user_guess red against how many hidden_code red and then subtract exact red matches
  def find_close_matches(user_guess, hidden_code)
    ug_after_exact = user_guess.dup.join(",")
    hc_after_exact = hidden_code.dup.join(",")
    @exact_matches[:blue].times do
      ug_after_exact.sub!(/blue/, " ")
      hc_after_exact.sub!(/blue/, " ")
    end
    @exact_matches[:red].times do
      ug_after_exact.sub!(/red/, " ")
      hc_after_exact.sub!(/red/, " ")
    end
    @total_close_matches = ug_after_exact.split(",").count { |i| hc_after_exact.split(",").include?(i) } - @exact_matches[:blue] - @exact_matches[:red]
  end


# method needed to actually update board data structure
 def feedback(user_guess, hidden_code)
  feedback_array = []
  find_exact_matches(user_guess, hidden_code)
  find_close_matches(user_guess, hidden_code)
  feedback_array << @exact_matches[:blue] <<  @exact_matches[:red] <<  @total_close_matches
  change_to_color(user_guess, feedback_array)
  puts "this is the hidden code: #{hidden_code}"
  render_board
  reset_variables
 end


# change feedback_array to an array with correct colors for feedback 
 def change_to_color(user_guess, feedback_array)
   feedback_colors = []
   feedback_array[0].times do |n|
     feedback_colors << "black"
   end
   feedback_array[1].times do |n|
     feedback_colors << "black"
   end
   feedback_array[2].times do |n|
     feedback_colors << "white"
   end
   @board.push(user_guess).push(feedback_colors)
 end


 def reset_variables
   @exact_matches[:blue] = 0
   @exact_matches[:red] = 0
   @total_close_matches = 0
 end



end # end of class
