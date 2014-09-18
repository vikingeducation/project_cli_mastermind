require './mastermind.rb'
class AI < Mastermind #inherit from Mastermind class in order to have direct access to check_guess method
  def initialize(code)
    @code=code
    @last_guess
  end

  def make_guess
      guess=smart_guess
      puts "The AI guessed #{guess}.\n"
      check_guess(guess.upcase)
  end

  def smart_guess
    next_guess=[]
    unless @last_guess.nil?
      0.upto(@result.length-1) do |index|
        if @result[index] == "R"
          next_guess[index] = @code[index]
        end
      end
    end

    0.upto(3)do |index|
      if next_guess[index].nil?
        next_guess[index] = (65..70).to_a.sample.chr.to_s
      end
    end

    @last_guess = next_guess
    next_guess.join('')
  end



end