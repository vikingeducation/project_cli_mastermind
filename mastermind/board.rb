class Board
  def initialize
    @top_border = '-'
    @side_border = '|'
    @correct = '!'
    @close = '+'
    @guess_history = []
    @feedback = []
  end

  def guess_history
    @guess_history
  end

  def feedback
    @feedback
  end

  def render(guess=[], accuracy={})
    history_update(guess, accuracy)
    puts
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