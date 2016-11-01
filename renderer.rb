class Renderer

	def self.render_board(guesses, feedback)
    # Guesses    | Feedback
    # 1. A B D C | 0 0 1 2
    # 2. 
    unless guesses.empty?
      puts "   Guesses | Feedback"
      guesses.each_with_index do |guess, index|
        print "#{index + 1}. "
        print "#{guess.join(" ")}"
        print " | "
        print "#{feedback[index].join(" ")}"
        puts
      end
    end
  end

  def self.ask_for_role
    puts "Would you like to be the codebreaker or codemaker? (b/m)"
    print "> "
  end

  def self.ask_for_input
  	puts "Enter a four letter code from A,B,C,D,E,F: (ie ABCD)"
    print "> "
  end

  def self.welcome
  	puts "Welcome to Mastermind!"
  	puts "Your opponent will select a 4 letter code."
  	puts "The code will contain letters A-F"
  	puts "and a letter can appear multiple times in the code."
  	puts "You have 12 chances to guess the code."
  	puts "After each guess you will receive feedback to help you narrow your choices:"
  	puts "#{Rainbow("O").red} means that letter is not in the code"
  	puts "#{Rainbow("O").yellow} means that letter is in the code, but in the wrong position"
  	puts "#{Rainbow("O").green} means that letter is in the correct position!"
  	puts "Good luck!"
  end

  def self.invalid_input_error
  	puts "Invalid input! Enter a four letter code with letters A-F"
  end

  def self.invalid_role_input_error
    puts "Invalid input! Enter 'b' or 'm'"
    print "> "
  end

  def self.victory_message
    puts "You are a Mastermind!"
  end

  def self.loss_message
    puts "Sorry, you couldn't crack the code!"
  end
end