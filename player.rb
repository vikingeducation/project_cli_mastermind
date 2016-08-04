class Player
  attr_accessor :name

  def initialize
    @name = name
  end

  def ask_name
    @name = gets.chomp
  end
end
