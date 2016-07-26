class ComputerAi

  def initialize_code
    result = []
    4.times do
      result << ['1', '2', '3', '4', '5', '6'].sample
    end
    result
  end

  def make_guess

  end

  # Attention! The methods below are private.
  private

  def pool
    (1111..6666).select do |num|
      !num.to_s.split("").include? "0"
    end
  end
end
