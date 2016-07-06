require_relative 'player'
class Computer < Player

  def get_code
    4.times do
      @guess << LEGAL_COLORS.sample
    end
    @guess
  end

  def get_secret_code
    response = []
    4.times do
      response << LEGAL_COLORS.sample
    end
    response
  end

end
