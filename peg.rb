class Peg

  attr_reader :color_num
  
  

  def initialize(color)
    @color_num = $COLOR_TO_NUM[color.to_sym]
  end
end