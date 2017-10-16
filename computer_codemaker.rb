class ComputerCodemaker

  def initialize(colours)
    @colours = colours
  end

  def get_combination
    combination = []
    4.times {|colour_index| combination << @colours[rand(0..5)]}
    combination
  end
end