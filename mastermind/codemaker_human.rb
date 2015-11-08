class CodemakerHuman < Codemaker
  include DataIO

  def get_feedback
    loop do
      feedback = get_input("Enter your feedback for the guess (* for correct position and color, + for correct color wrong position)")
      # TODO:  can be less than four so fix
      break if valid_entry_format?(feedback)
    end
    @board.place_feedback(feedback)
  end

  private

  def get_code
    code = []
    loop do
      code = get_input("Enter your secret code (options: r, b, g, y, p, o)")
      break if valid_entry_format?(code) && valid_code?(code)
    end
    code
  end

  def valid_code? code
    result = true
    code.each do |peg|
      unless @@valid_guesses.include? peg
        puts "I don't recognize those colors. Try again."
        result = false
        break
      end
      unless code.count(peg) == 1
        puts "Duplicates not allowed. Try again."
        result = false
        break
      end
    end
    result
  end

end