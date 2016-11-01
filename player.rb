class Player
  attr_reader :sequence
  attr_accessor :colors
  def initialize
    @sequence = nil
  end
  def get_sequence
    raise NotImplementedError
  end

  private
  attr_writer :sequence
end

class HumanPlayer
  def get_sequence
    until valid?
      sequence = Listener.get_formatted.split
    end
  end

  def valid?
    return false unless sequence.length ==4
    sequence.all? {|letter| colors.include?(letter)}
  end
end



class ComputerPlayer
  def get_sequence
  end
end