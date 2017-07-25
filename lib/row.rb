class Mastermind::Row
  def self.colors(*colors)
    colors.each do |color|
      define_method("place_#{color}_peg") do |position = nil|
        position ? @data[position] = color : @data << color
      end
    end
  end

  def self.hole(value)
    define_method(:hole) { value }
  end

  def self.peg(value)
    define_method(:peg) { value }
  end

  def initialize
    @data = []
  end

  def to_s
    4.times.map do |index|
      @data[index] ? peg.colorize(@data[index]) : hole
    end.join(' ')
  end
end

class Mastermind::CodeRow < Mastermind::Board::Row
  colors :blue, :magenta, :green, :yellow
  hole '.'
  peg '#'
end

class Mastermind::KeyRow < Mastermind::Board::Row
  colors :white, :red
  hole '.'
  peg '*'
end
