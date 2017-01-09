class Board
  PEG_COLOURS = %w(B G O P R Y).freeze
  attr_accessor :peg_slots, :peg_assist, :assist_array, :pegs_target # target TEMP

  def initialize
    @pegs_target = []
    @peg_slots = Array.new(12) { Array.new(4) { |i| i = '-' } }
    @peg_assist = {
      right_peg_NOT_place:  0,
      right_peg_AND_place:  0,
      assist_history: Array.new(12) { Array.new(4) { |i| i = 0 } }
    }
  end

  def render
    peg_slots.each_with_index do |row, ind|
      row.each do |slot|
        print slot + ' '
      end
      Gui.print_assist(peg_assist[:assist_history], ind)
      puts
    end
    nil
  end

  attr_accessor :pegs_target

  def generate_target
    4.times do |ind|
      pegs_target[ind] = PEG_COLOURS.sample
    end
  end

  def generate_assist(turn)
    reset_assist
    right_colors_choosen(turn)
    right_peg_in_place(turn)
    peg_assist[:assist_history][turn] = [peg_assist[:right_peg_NOT_place], peg_assist[:right_peg_AND_place]]
  end

  def reset_assist
    peg_assist[:right_peg_NOT_place] = 0
    peg_assist[:right_peg_AND_place] = 0
  end

  def right_peg_in_place(turn)
    peg_slots[turn].each_with_index do |peg, ind|
      if pegs_target[ind] == peg
        peg_assist[:right_peg_AND_place] += 1
        peg_assist[:right_peg_NOT_place] -= 1
      end
    end
    nil
  end

  def right_colors_choosen(turn)
    temp = peg_slots[turn].uniq.dup
    temp.each do |peg|
      if pegs_target.include?(peg)
        peg_assist[:right_peg_NOT_place] += pegs_target.count(peg)
      end
    end
    nil
  end

  def insert_guess(turn, guess)
    peg_slots[turn] = guess
    nil
  end

  def validate_choice(choice)
    all_correct_peg = true
    choice.each do |peg|
      all_correct_peg = false unless PEG_COLOURS.include?(peg)
    end

    if all_correct_peg
      return true
    else
      Gui.redo_selection
      return false
    end
  end
end

# Blue, Green, Orange, Purple, Red, Yellow
