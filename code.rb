class Code

  PEGS = {1 => Peg.red, 2 => Peg.orange, 3 => Peg.yellow, 4 => Peg.green, 5 => Peg.blue, 6 => Peg.purple}

  attr_reader :pegs

  def initialize
    @pegs = []
  end

  def ==(other_code)
    4.times do |index|
      return false unless pegs[index].display == other_code.pegs[index].display
    end
    true
  end

  def add_peg(peg)
    @pegs << peg
  end

  def self.random
    code = new
    code.add_peg(PEGS.values.sample) until code.full?
    code
  end

  def self.from_array(array)
    code = new
    array.each do |i|
      code.add_peg(PEGS[i])
    end
    code
  end

  def full?
    @pegs.length == 4
  end

  def display
    output = []
    @pegs.each do |peg|
      output << peg.display
    end
    output.join(' ')
  end
end
