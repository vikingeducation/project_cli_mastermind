class WinningPattern

  attr_reader :code

  def initialize(*pattern)
    @pattern = pattern
    @code = []
  end

  def translate
    @pattern.each do |element|
      @code << element[0]
    end
  end

end