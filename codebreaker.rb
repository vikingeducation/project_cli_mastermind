class Codebreaker

  def initialize
    @computer_board = []
    @user_guess = []
    @prev_guesses = []
    @turn_number = 1
  end

  def play
    welcome_message
    generate_board
    loop do
      if @turn_number > 12
        fail_message
      else
        guess_prompt
        validate_guess_input
        compare_guess_to_board
        prev_guesses
        clear_user_guess
        @turn_number += 1
      end
    end
  end
  
  def welcome_message
    puts ""
    puts "Welcome to Mastermind, codebreaker! Please type four numbers between 1 and 6 separated by commas at each prompt."
  end
  
  def generate_board
    4.times do
      @computer_board << rand(1..6)
    end
  end
  
  def fail_message
    puts ""
    puts "Sorry, you lost!"
    puts ""
    puts "The correct code was: #{@computer_board}"
    puts ""
    exit
  end
  
  def clear_user_guess
    @user_guess = []
  end
  
  def validate_guess_input
    @user_guess.each do |guess|
      if guess == 0
        puts ""
        puts "Please enter valid guesses!"
        exit
      end
    end
  end
  
  def guess_prompt
    puts ""
    puts "Please type in your four guesses:"
    guessed = gets.chomp.strip.split(",")
    guessed.each do |num|
      @user_guess << num.to_i
    end
  end
  
  def compare_guess_to_board
    puts ""
    if @user_guess == @computer_board
      puts "Congratulations, you won!"
      exit
    end
    @user_guess.each_with_index do |guess, index|
      if guess == @computer_board[index]
        puts "#{guess} at position #{index + 1} is correct!"
      elsif @computer_board.include? guess
        puts "#{guess} is in there somewhere... just not here!"
      else
        puts "#{guess} is nowhere to be found. Try a different number!"
      end
    end
  end
    
  def prev_guesses
    puts ""
    puts "Previous guesses:"
    puts ""
    @prev_guesses << @user_guess
    @prev_guesses.each_with_index do |past_guess, guess_num|
      puts "#{guess_num + 1}. #{past_guess}"
    end
  end

end