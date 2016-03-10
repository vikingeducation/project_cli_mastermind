class Computer

  def create_code
    code = {}
    (1..4).each do |i|
      code[i] = rand(1..6)
    end
    code
  end

end