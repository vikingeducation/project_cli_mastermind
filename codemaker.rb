#codemaker.rb

class CodeMaker < Player

  def initialize(name)
    super(name)

  end

  def get_code
    make_code
  end

  private
  def make_code
    code = {}
    4.times {|index| h[index] = %w(a e i o u y).rand(6) }
    code
  end
  
end