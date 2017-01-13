class Board

  attr_reader :all_feedback

  def initialize
    @board = Array.new(12){ Array.new(2) { Array.new(4) }}
    @feedback = []
    @all_feedback = []
  end

  def reset
    @feedback = []
  end

  def render
    puts
    @board.each do |row|
      row.each_with_index do |col, i|
        col.each do |sub_col|
          if i == 0
            print_guess(sub_col)
          else
            print_feedback(sub_col)
          end
        end
        print "|" if i == 0
      end
      puts
    end
    puts "● = correct position and colour/ number."
    puts "◯ = correct colour/ number, wrong position."
  end

  def update(guess)
    add_guess(guess)
    add_feedback
  end


  def get_feedback(guess, code)
    remainders = guess.dup
    guess.each_with_index do |g, i|
      if code[i] == g
        @feedback << 2
        remainders -= [g]
      end
    end
    code.uniq.each do |l|
      @feedback << 1 if remainders.uniq.include?(l)
    end
    @feedback = [0] if @feedback.empty?
    @feedback.sort.reverse!
    @all_feedback.concat([@feedback])
    @feedback
  end

  private

  def add_feedback
    (0...@board.size).reverse_each do |row|
      if @board[row][1].all? { |i| i.nil?}
        @board[row][1] = @feedback
        break
      end
    end
  end

  def add_guess(guess)
    (0...@board.size).reverse_each do |row|
      if @board[row][0].all? { |i| i.nil?}
        @board[row][0] = guess
        break
      end
    end
  end

  def print_guess(char)
    print char.nil?? ' - ' : " #{char} ".colourise
  end

  def print_feedback(char)
    print ' - ' if char.nil?
    print ' ● ' if char == 2
    print ' ◯ ' if char == 1
  end

end
