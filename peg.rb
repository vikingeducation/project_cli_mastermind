class Peg
  def initialize(display)
    @display = display
  end

  def ==(other_peg)
    display == other_peg.display
  end

  def display
    @display
  end

  def self.red
    new(Rainbow("1").red)
  end

  def self.orange
    new(Rainbow("2").cyan)
  end

  def self.yellow
    new(Rainbow("3").yellow)
  end

  def self.green
    new(Rainbow("4").green)
  end

  def self.blue
    new(Rainbow("5").blue)
  end

  def self.purple
    new(Rainbow("6").magenta)
  end
end
