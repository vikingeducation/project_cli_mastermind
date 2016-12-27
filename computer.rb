class Computer < Player 
  def initialize(current_role) 
    name = generate_a_terrible_name
    super(current_role, name)
    @previous_guess = nil
  end 

  def make_code
    code = []
    while code.size < 4
      code << @@colors.sample 
    end
    code
  end
  
  def guess(n, feedback)
    if feedback.nil?  # for initial guess (guess #1)
      color1 = @@colors.sample
      color2 = (@@colors - [color1]).sample
      guess = [color1] * 2 + [color2] * 2
      @remaining_codes = generate_all_codes
      @previous_guess = guess
      @remaining_codes -= [guess]
    else  # guess #2+
      guess = intelligent_guess(feedback)
      @previous_guess = guess
      @remaining_codes -= [guess]
    end
    print "Press enter to see guess ##{n} for the AI > "
    quit_game if gets.chomp == 'q'
    guess
  end

  private

  # needs to DRY
  def intelligent_guess(feedback) 
    remove_these_codes = []
    @remaining_codes.each do |code|
      red_key_ct = 0
      code.each_with_index do |code_peg, position|
        red_key_ct += 1 if @previous_guess[position] == code_peg
      end
      intersection_with_dup = (code & @previous_guess).flat_map do |code_peg|
        [code_peg] * [code.count(code_peg), @previous_guess.count(code_peg)].min 
      end
      gray_key_ct = intersection_with_dup.size - red_key_ct
      remove_these_codes << code unless {red: red_key_ct, gray: gray_key_ct} == feedback
    end
    @remaining_codes -= remove_these_codes
    @remaining_codes.sample
  end

  def generate_all_codes
    all_codes = []
    @@colors.each do |color1|
      @@colors.each do |color2|
        @@colors.each do |color3|
          @@colors.each do |color4|
              all_codes << [color1, color2, color3, color4] 
          end
        end
      end
    end
    all_codes
  end

  def generate_a_terrible_name
    name_length = (3..5).to_a.sample
    letters = ('a'..'z').to_a
    vowels = %w(a e i o u)
    consonants = letters - vowels
    char_array = []
    name_length.times do
      rand(5) > 1 ? char_array << consonants.sample : char_array << vowels.sample  
    end
    "AI #{char_array.join.capitalize}"
  end

end