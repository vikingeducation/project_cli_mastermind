class Board

  def initialize
    @rows = Array.new(12) { Array.new(4, nil) }
    @feedback = Array.new(12) { Array.new(4, nil) }
  end

  def render
    linewidth = 20
    puts
    puts "GUESSES".center(20) + "FEEDBACK".center(15)
    puts 
    11.downto(0) do |i|
      @rows[i].each do |item|
        if item == nil
          print " --- "
        else
          print "  #{item}  "
        end
      end
      print "|"

      @feedback[i].each do |item|
        if item == nil
          print " - "
        else
          print " #{item} "
        end
      end
      puts
    end
    puts
    puts
  end

  def process(guess, code, turn)
    register_guess(turn, guess)
    feedback = gets_feedback(guess, code)
    insert_feedback(turn, feedback)
  end

  def register_guess(turn, guess)
    @rows[turn] = guess
  end

  def code
    @code
  end

  def gets_feedback(guess, code)
    feedback = []
    black_pegs = black_pegs(guess, code)
    white_pegs = white_pegs(guess, code) - black_pegs
    black_pegs.times { feedback << "B" }
    white_pegs.times { feedback << "W" }
    feedback
  end

  def black_pegs(guess, code)
    black = 0
    code.each_with_index do |item, i|
      black += 1 if guess[i] == code[i]
    end
    black
  end

  def white_pegs(guess, code)
    white = 0
    (4 - (code-guess).size).times { white += 1 }
    white
  end

  def insert_feedback(turn, feedback)
    @feedback[turn] = feedback
  end
end
