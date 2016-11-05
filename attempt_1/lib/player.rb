class Player

  def get_sequence
    raise NotImplementedError
  end

  def valid?(colors, sequence)
    return false unless sequence
    return false unless sequence.length ==4
    sequence.all? {|letter| colors.include?(letter)}
  end

  
end

class HumanPlayer < Player
  def get_sequence(colors)
    sequence = nil
    until valid?(colors, sequence)
      sequence = Listener.get_formatted.split("")
    end
    sequence
  end
end

class ComputerPlayer < Player
  def get_sequence(colors)
    sequence = []
    4.times do 
      sequence << colors.sample
    end
    # sequence ########### TEMP
    ['b','b','b','r'] ########### TEMP
  end
end