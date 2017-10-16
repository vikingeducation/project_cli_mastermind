class Board

  def initialize(code, pegs)
    @board = [[nil,nil,nil,nil],[nil,nil,nil,nil]]
    @code = code
    @stored_scores = {}
    @pegs = pegs
  end

  def add_pegs(picked_colours)
    @board[0] = picked_colours
    @board[1] = score_provider
  end

  def add_turn_to_storage(turn)
    @stored_scores[turn] = @board.dup
  end

  def check_in_storage(turn)
    @stored_scores.values_at(turn)
  end

  def render(turn)
    puts
    puts
    puts "    TURN NUMBER #{turn}"
    1.upto(turn-1) do |turn_number|
      break if @stored_scores  == {}
      colour_and_score_pegs = check_in_storage(turn_number)
      puts "|*|*|*|*| * * |#{colour_and_score_pegs[0][1][0]}|#{colour_and_score_pegs[0][1][1]}|"
      puts "|#{colour_and_score_pegs[0][0][0]}|#{colour_and_score_pegs[0][0][1]}|#{colour_and_score_pegs[0][0][2]}|#{colour_and_score_pegs[0][0][3]}| * * |#{colour_and_score_pegs[0][1][2]}|#{colour_and_score_pegs[0][1][3]}|"
      puts
    end
  end

  def score_provider
    final_score = score_for_colours_in_position + score_for_colours_only
    (4-final_score.size).times {|iterator| final_score << "-"} if final_score.size != 4
    final_score
  end

  private

  def score_for_colours_in_position
    feedback = []
    4.times do |position|
      feedback << @pegs[1] if @code[position] == @board[0][position]
    end
    feedback
  end

  def score_for_colours_only
    feedback = []
    code_as_string = @code.join(",")
    4.times do |position|
      if code_as_string.include?(@board[0][position]) \
                          && @code[position] != @board[0][position]
        feedback << @pegs[0]
        code_as_string.delete! @board[0][position]
      end
    end
    feedback
  end

end