class Player
  attr_reader :sequence
  attr_accessor :colors
  def initialize
    @sequence = nil
  end
  def get_sequence
    raise NotImplementedError
  end

  def valid?(colors)
    return false unless sequence.length ==4
    sequence.all? {|letter| colors.include?(letter)}
  end

  private
  attr_writer :sequence
end

class HumanPlayer
  def get_sequence(colors)
    until valid?(colors)
      sequence = Listener.get_formatted.split
    end
  end
end



class ComputerPlayer
  def get_sequence(colors)
    4.times do 
      sequence << colors.sample
    end
  end
end