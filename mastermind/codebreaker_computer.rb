class CodebreakerComputer < Codebreaker

  def get_guess
    current_guess = @@valid_guesses.sample(4)
    @board.place_guess(current_guess)
  end
end