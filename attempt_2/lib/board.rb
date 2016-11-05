class Board

  attr_accessor :code, :guess

  def initialize
    @code = nil
    @guess = nil
    @code_temp = nil
    @guess_temp = nil
    @indices_covered = []
  end

  def compare
    @indices_covered = []
    if !@code || !@guess
      raise "Error: cannot compare nil values"
    end
    if @code.length != @guess.length 
      raise "Error: code & guess lengths do not match."
    end
    exact_matches = get_exact_matches
    @code_temp = remove_exacts(@code)
    @guess_temp = remove_exacts(@guess)
    close_matches = get_close_matches
    { exact: exact_matches, close: close_matches }
  end

  private

  def get_exact_matches
    exact_matches = 0
    @code.length.times do |index| # code.length == guess.length 
      if @code[index] == @guess[index]
        exact_matches += 1 
        @indices_covered << index
      end
    end
    exact_matches
  end

  def get_close_matches
    close_matches = 0
    @code_temp = sort(@code_temp)
    @guess_temp = sort(@guess_temp)
    @code_temp.length.times do |index|
      if @code_temp[index] == @guess_temp[index]
        close_matches += 1
      end
    end
    close_matches
  end

  def remove_exacts(string)
    char_array = string.split("")
    char_array.reject!.with_index do |char, index|
      @indices_covered.include?(index)
    end
    char_array.join
  end

  def sort(string)
    string.split("").sort.join
  end

end

