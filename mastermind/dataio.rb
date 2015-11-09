module DataIO
  VALID_GUESSES = ['r', 'b', 'g', 'y', 'p', 'o']
  @@valid_feedbacks = ['*', '+']

  private

  def valid_entry_format? entry
    if entry.is_a?(Array) && entry.size == 4
      true
    else
      puts "Your entry is improperly formatted.  You need 4 items separated by commas."
    end
  end

  def get_input prompt
    puts prompt
    print " > "
    gets.chomp.split(',')
  end

  def valid_entries? entry, valid_options
    # if entry.all?()
    if entry.select{|item| valid_options.include?(item)}.size == entry.size
      true
    else
      puts "Hmm, I don't recognize those options. Try again..."
    end
  end

  def feedback_algorithm code, guess
    feedback = []

    # Check correct color and position
    index = 0
    while index < guess.size
      if guess[index] == code[index]
        feedback << '*'
        guess.delete_at(index)
        code.delete_at(index)
      else
        index += 1
      end
    end

    # Check what's left for correct color in wrong position
    guess.each do |peg|
      if code.include?(peg)
        feedback << '+'
        # Delete that one copy of the matching guess in the code copy
        code.delete_at(code.index(peg))
      end
    end

    feedback
  end

end