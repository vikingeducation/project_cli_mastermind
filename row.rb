class Row 
  attr_accessor :slots
  def initialize
    @slots = []
  end
  
  def populate_row ( colors )
    colors.each do | color |
      @slots << Peg.new( color )
    end
  end

  def to_s
    colors = @slots.map { |slot| slot.color }
    colors.join(", ")
  end

  def ==(other_row)
    self.slots == other_row.slots
  end
end