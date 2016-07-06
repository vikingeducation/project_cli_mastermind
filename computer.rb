class Computer < Player
  #input_code
    #generate array of colors

  def get_pegs
    pegs = (4..6).sample
    puts "You're playing with #{pegs} pegs."
    pegs
  end

  def get_colors
    colors = (2..8).sample
    puts "You're playing with #{colors} colors."
    colors
  end
end