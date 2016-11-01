class Listener
  def self.get_numeric
    get_formatted.to_i
  end

  def self.get_formatted
    gets.strip.downcase
  end

  def get_numeric
    self.class.get_numeric
  end

  def get_formatted
    self.class.get_formatted
  end
end