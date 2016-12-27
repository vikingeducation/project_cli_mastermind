require './string'

class Player
  @@colors = %w{r g y b m c} 

  attr_accessor :name, :current_role, :points

  def initialize(current_role, name = nil)
    @current_role = current_role
    @name = name
    @points = 0
  end

  private

  def quit_game
    puts "Thanks for playing!"
    puts "Exiting now..."
    exit
  end
end
