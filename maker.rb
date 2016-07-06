class Maker < Player
  def initialize
  end

  def get_code
    response = []
    4.times do
    response << Peg.new(COLOR_TO_NUM[keys].sample)
    end
  end

end