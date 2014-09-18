class Mastermind
  def play
    codebreaker()
  end

  def generate_code
    (1..4).map { ('a'..'f').to_a[rand(6)] }
  end

  def codebreaker(code=generate_code)
    @attempts = 0
    guess = []
    while @attempts < 12 && guess != code
      guess = gets.chomp.downcase.split('')
      guess_evaluation(code, guess) if guess.length == 4
    end
  end

  def guess_evaluation(code, guess)
    attempt = Attempt.new
    @attempts += 1
    accuracy = attempt.check_accuracy(code, guess)
    puts "#{accuracy["correct"]} correct and #{accuracy["close"]} letters in wrong position."
  end
end

class Attempt
  def check_accuracy(code, guess)
    @code_copy = code.dup
    @guess_copy = guess.dup
    { "correct" => check_correct(@code_copy, @guess_copy), "close" => check_close(@code_copy, @guess_copy) }
  end

  def check_correct(code_copy, guess)
    correct = 0
    correct_array(code_copy, guess).reverse.each do |correct_index|
      correct += 1
      guess.delete_at(correct_index)
      code_copy.delete_at(correct_index)
    end
    correct
  end

  def correct_array(code_copy, guess)
    correct_array = []
    code_copy.each_with_index do |code_copy_entry, code_copy_index|
      if code_copy_entry == guess[code_copy_index]
        correct_array << code_copy_index
      end
    end
    correct_array
  end

  def check_close(code_copy, guess)
    close = 0
    guess.each_with_index do |guess_entry, guess_index|
      marker = true
      code_copy.each_with_index do |code_copy_entry, code_copy_index|
        if (code_copy_entry == guess_entry) && marker
          code_copy.delete_at(code_copy_index)
          close += 1
          marker = false
        end
      end
    end
    close
  end
end

class Player

end

game = Mastermind.new
game.play