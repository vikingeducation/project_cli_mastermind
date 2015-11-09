class CodemakerHuman < Codemaker

  def get_feedback
    @board.render
    puts "Secret code: #{@code.join(' ')}"
    feedback = []
    loop do
      feedback = get_input("Enter your feedback for the guess (* for correct position and color, + for correct color wrong position)")
      if feedback.is_a? Array
        break if @board.place_feedback(feedback)
      end
    end

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
      unless VALID_GUESSES.include? peg
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