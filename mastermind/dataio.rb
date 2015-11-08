module DataIO

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
    if entry.select{|item| valid_options.include?(item)}.size == entry.size
      true
    else
      puts "Hmm, I don't recognize those options. Try again..."
    end
  end

end