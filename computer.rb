# computer.rb

# Player when the user is the not the codemaker
class Computer

  attr_accessor :code, :guess

  def generate_code
    generated_code = []
    4.times{ generated_code << $colors[rand(6)] }
    @code = generated_code
  end

  def get_guess
    generated_guess = []
    4.times{ generated_guess << $colors[rand(6)] }
    @guess = generated_guess
  end
end