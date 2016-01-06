module Correctitudable
  def determine_correctitude(guess, solution)
    guess_pegs = guess.pegs.dup
    solution_pegs = solution.pegs.dup

    red_pegs = guess_pegs.zip(solution_pegs).select { |a,b| a == b }.count

    white_pegs = 0

    guess_pegs.each do |peg|
      if (index = solution_pegs.index(peg))
        white_pegs += 1
        solution_pegs.delete_at(index)
      end
    end

    white_pegs -= red_pegs

    [red_pegs, white_pegs]
  end
end
