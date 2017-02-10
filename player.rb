class Player
  attr_reader :move, :role

  def initialize
    @move = nil
    @role = nil
  end

  # prompts the user for his next guess/code
  def get_next_move
    move = role == 'b' ? "guess" : "code"

    loop do
      print "Please enter your #{move}: "
      input = gets.chomp.downcase

      if Mastermind::QUIT_OPTIONS.include?(input)
        @move = input
        break
      end

      formatted_move = format_move(input)
      if valid_move?(formatted_move, Mastermind::CODE_COLORS)
        @move = formatted_move
        break
      else
        puts "That #{input} is invalid. Please try again."
      end
    end
  end

  # checks what role the player wants to be,
  # either the codebreaker or the codesetter
  def set_role
    loop do
      puts "Please enter what role you'd like to be."
      puts "You can either (b)reak the code, or (s)et the code."
      print "Please enter 'b' or 's': "

      input = gets.chomp.downcase

      if input == "b"
        @role = :codebreaker
        break
      elsif input == "s" 
        @role = :codesetter
        break
      else
        puts "That is an invalid role. Please try again."
        puts
      end
    end
  end

  private

  # formats player guess into an expected format
  def format_move(move)
    move.split(/\W+/).map { |color| color.downcase.to_sym }
  end

  # checks if the player's guess is valid
  def valid_move?(move, code_colors)
    move.length == 4 && move.all? { |color| code_colors.include?(color) }
  end
end
