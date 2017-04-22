class HumanPlayer

  attr_reader :guess, :hidden_code

  def initialize
  end

  # break code

  def guess
    puts "What is your guess? (in format color-color-color-color or q to quit)"
    @guess = gets.chomp.downcase.split("-")
    case @guess[0]
    when "q"
        exit
    else
      unless @guess.all? { |word| word == "blue" || word == "red"} && @guess.length == 4
        puts "That is not a valid entry, please try again"
        self.guess
      end
      @guess
    end
  end


  # make code

  def hidden_code
    puts "Please enter your hidden code in the format color-color-color-color"
    @hidden_code = gets.chomp.downcase.split("-")
  end



end # end of class
