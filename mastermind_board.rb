class Board
  def initialize()
    @pegs_target = []
    @peg_slots =  Array.new(12){ Array.new(4) { |i| i = '-'}}
  end

  def render
    @peg_slots.each do |row|
      row.each do |slot|
        print slot + " "
      end
      puts
    end
    return
  end
end
