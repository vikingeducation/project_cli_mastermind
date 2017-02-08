# Maintains game board state
class Board
  # initialize board
  def initialize
    # set up blank data structure
    @board = Array.new(12) { Array.new(4) }
    @guess_count = 0
    @valid_colors = ["red", "orange", "yellow", "green", "blue", "violet"]
  end

  # render
  def render
    line_width = 7

    puts
    # loop through data structure
    @board.each_with_index do |row, i|
      print " " if i < 9
      print i + 1
      print " - "

      # display an existing peg if any, else blank
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

  # set_code
  def set_code(code)
    # IF valid_code?
    if valid_code?(code)
      # set code
      @secret_code = code
      #ELSE
    else
      puts "Your code doesn't follow the rules."
    end
  end

  # secret_code
  def secret_code
    # If secret_code has been set, return the secret_code
    @secret_code ? @secret_code : false
  end

  # add_guess
  def add_guess(guess)
    # IF valid_code?
    if valid_code?(guess)
      # place guess
      @board[@guess_count] = guess
      # increment guess counter
      @guess_count += 1
      #ELSE
    else
      # display error message
      puts "Your code doesn't follow the rules."
    end
  end

  # winning_combination?
  def winning_combination?
    # does the last guess have 4 exact_pegs?
    @board.each do |row|
      return true if exact_pegs(row) == 4
    end
    false
  end

  # full?
  def full?
    # does every row contain a guess?
    @guess_count == 12
  end

  def valid_colors
    @valid_colors
  end

  private

  # valid_code?
  def valid_code?(code)
    # is each peg in the code a valid_color?
    code.each do |peg|
      return false unless valid_color?(peg)
    end
    true
  end

  # valid_color?
  def valid_color?(peg)
    # is the peg included in the list of valid_colors?
    @valid_colors.include?(peg)
  end

  # close_pegs(guess)
  def close_pegs(guess)
    # number of pegs in the guess wth correct color, but incorrect location
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

  # exact_pegs
  def exact_pegs(guess)
    # number of pegs in the guess with correct color, and correct location
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