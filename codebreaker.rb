class Codebreaker
  def initialize
    @board = []
    @turn_count = 1
    @guess_board = []
    @user_guess = []
    @full_board = []
  end
  
  def lets_play
    board_generator
    puts "Great, you have 12 turns, you must guess the correct color combo. 1 means red, 2 means blue, 3 means green, 4 means yellow, 5 means purple, and 6 means taupe."
    sleep 1.5
    while true
      guess_checker
    end
  end
    

  def board_generator
    4.times do 
      @board << (1..6).to_a.sample
    end
  end
  
  def board_answer
    puts @board.to_s
  end 
  
  def exact_checker
    i = 0
    j = 1
    @user_guess.each do |x|
      if x == @board[i]
        puts "#{x} in position #{j} is an exact match! \n\n"
      elsif @board.include?(x)
        puts "#{x} in position #{j} is close but not in the right position!\n\n"
      end
      i += 1
      j += 1
    end
  end
  
  def guess_checker
    turn_check
    puts "What is your guess? (enter four colors separately) You are on turn # #{@turn_count}"
    #COMMENT OF DESTRUCTION
    @user_guess1 = gets.chomp.to_i
    @user_guess2 = gets.chomp.to_i
    @user_guess3 = gets.chomp.to_i
    @user_guess4 = gets.chomp.to_i
    @user_guess = []
    @user_guess << @user_guess1
    @user_guess << @user_guess2
    @user_guess << @user_guess3
    @user_guess << @user_guess4
    if @board == @user_guess
      puts "Congratulations! You win! You guessed right at turn number #{@turn_count}."
      exit
    end
    past_guesses
    #board_answer
    exact_checker
    @turn_count += 1
  end
  
  def past_guesses
    puts "Past guesses! \n\n"
    sleep 1
    @full_board << @user_guess
    i = 1
    @full_board.each do |guesses|
      puts "#{i}. #{guesses}"
    end
  end
  
  def turn_check
    if @turn_count > 12
      puts "I'm sorry, you are out of turns and you lose! Better luck next time!"
      puts "Correct answer:"
      board_answer
      exit
    end
  end
end