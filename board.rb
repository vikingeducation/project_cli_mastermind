class Board
  def initialize
    @board = Array.new(12) { Array.new(4) }
    @guess_count = 0
    @valid_colors = ["red", "orange", "yellow", "green", "blue", "violet"]
  end

  def render
    line_width = 7

    puts
    @board.each_with_index do |row, i|
      print " " if i < 9
      print i + 1
      print " - "

      row.each do |slot|
        print "[ "

        if slot.nil?
          line_width.times { print "-" }
        else
          padding = line_width - slot.length || 1
          print slot
          padding.times { print " " }
        end

        print " ] "
      end
      print " " * 3
      puts "Exact: #{exact_pegs(row)}, Close: #{close_pegs(row)}"
    end
    puts
  end

  def set_code(code)
    if valid_code?(code)
      @secret_code = code
    else
      puts "Your code doesn't follow the rules."
    end
  end

  def secret_code
    @secret_code ? @secret_code : false
  end

  def add_guess(guess)
    if valid_code?(guess)
      @board[@guess_count] = guess
      @guess_count += 1
    else
      puts "Your code doesn't follow the rules."
    end
  end

  def winning_combination?
    @board.each do |row|
      return true if exact_pegs(row) == 4
    end
    false
  end

  def full?
    @guess_count == 12
  end

  def valid_colors
    @valid_colors
  end

  private

  def valid_code?(code)
    code.each do |peg|
      return false unless valid_color?(peg)
    end
    true
  end

  def valid_color?(peg)
    @valid_colors.include?(peg)
  end

  def close_pegs(guess)
    possible_matches = @secret_code.dup
    return 0 unless @secret_code

    guess.each_with_index do |peg, i|
      if possible_matches[i] == peg
        possible_matches[i] = "exact"
      end
    end

    guess.each_with_index do |peg, i|
      if possible_matches.include?(peg)
        slot = possible_matches.find_index(peg)
        possible_matches[slot] = "close"
      end
    end

    possible_matches.count("close")
  end

  def exact_pegs(guess)
    matches = 0
    return 0 unless @secret_code

    @secret_code.each_with_index do |peg, i|
      if guess[i] == peg
        matches += 1
      end
    end

    matches
  end
end