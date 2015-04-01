class Codemaker < Codebreaker

  def welcome_message
    puts ""
    puts "Welcome to Mastermind, codemaker! Please type four numbers between 1 and 6 for the computer to guess."
  end
  
  def generate_board
    puts ""
    puts "Please type in your code as 4 comma-separated numbers:"
    guessed = gets.chomp.strip.split(",")
    guessed.each do |num|
      @computer_board << num.to_i
    end
  end
  
  def guess_prompt
    4.times do
      @user_guess << rand(1..6)
    end
    puts ""
    puts "The computer guesses... #{@user_guess}!"
  end
  
end