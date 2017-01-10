module PegColors
  def peg_colors
    %w(B G O P R Y).freeze
  end

  def pick_random_pegs
    peg_colors.sample
  end
end
