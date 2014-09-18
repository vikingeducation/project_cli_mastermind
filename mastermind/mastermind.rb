class Mastermind
  def play
    codebreaker()
  end

  def codebreaker(code=generate_code)
    @attempts = 0
    @board = Board.new
    guess = []
    @board.render
    while @attempts < 12 && guess != code
      guess = gets.chomp.downcase.split('')
      accuracy = guess_evaluation(code, guess) if guess.length == 4
      @board.render(guess, accuracy)
    end
    @board.render(code, accuracy) if @attempts == 12
  end

  def guess_evaluation(code, guess)
    attempt = Attempt.new
    @attempts += 1
    attempt.check_accuracy(code, guess)
  end

  def generate_code
    (1..4).map { ('a'..'f').to_a[rand(6)] }
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

class Board
  def initialize
    @top_border = '-'
    @side_border = '|'
    @correct = '!'
    @close = '+'
    @guess_history = []
    @feedback = []
  end

  def render(guess=[], accuracy={})
    history_update(guess, accuracy)
    puts @top_border*15
    display_rows
    puts @top_border*15
    puts @side_border + ' ' + display_code_bar(accuracy) + ' '*8 + @side_border
    puts @top_border*15
  end

  def display_rows
    12.times do |x|
      puts @side_border + ' ' + display(@guess_history[x]) + ' ' + @side_border + ' ' + display(@feedback[x]) + ' ' + @side_border
    end
  end

  def display_code_bar(accuracy)
    if accuracy['correct'] == 4 || @guess_history.length > 12
      return @guess_history.last.join
    else
      return '****'
    end
  end

  def history_update(guess, accuracy)
    @guess_history << guess if guess[0]
    if accuracy['correct']
      correct, close = accuracy['correct'], accuracy['close']
      @feedback << Array.new(correct, @correct) + Array.new(close, @close) + Array.new(4 - correct - close, ' ')
    end
  end

  def display(sequence)
    if sequence
      return sequence.join
    else
      return '    '
    end
  end
end

game = Mastermind.new
game.play