module Correctitudable
  def determine_correctitude(guess)
    guess_pegs = guess.pegs
    solution_pegs = @solution.pegs
    correct_position = 0
    correct_color = 0

    leftover_guess_pegs = []
    leftover_solution_pegs = []

    guess_pegs.each_with_index do |peg, index|
      if solution_pegs[index].display == peg.display
        correct_position += 1
      else
        leftover_guess_pegs << peg
        leftover_solution_pegs << solution_pegs[index]
      end
    end

    while leftover_guess_pegs.length > 0 && leftover_solution_pegs.length > 0
      popped_peg = leftover_guess_pegs.pop

      leftover_solution_pegs.each_with_index do |peg, index|
        if popped_peg.display == peg.display
          correct_color += 1
          leftover_solution_pegs.delete_at(index)
          break
        end
      end
    end

    display_dots(correct_position, correct_color)
  end
end

