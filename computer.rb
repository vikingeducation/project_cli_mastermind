class ComputerAi
  def initialize
    @select_pool = (1111..6666).select do |num|
      num.to_s.split("").all? do |each_element|
        ['1','2','3','4','5','6'].include? each_element
      end
    end
    @ai_guess = 1122
  end

  def initialize_code
    result = []
    4.times do
      result << ['1', '2', '3', '4', '5', '6'].sample
    end
    result
  end

  def make_guess board
    return num_to_arr 1122 if board.feedback_result.empty?
    @select_pool.select! do |num|
      board.feedback_for_reguess(num_to_arr(@ai_guess), num_to_arr(num)) == board.feedback_result
    end
    puts "the pool length is #{@select_pool.length}"
    @ai_guess = @select_pool.sample
    num_to_arr @ai_guess
  end

  # Attention! The methods below are private.
  private

  def num_to_arr num
    num.to_s.split("")
  end

end
