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

end