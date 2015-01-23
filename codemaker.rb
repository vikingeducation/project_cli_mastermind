class Codemaker
  def initialize
    @board = []
    @turn_count = 1
    @guess_board = []
    @user_guess = []
    @full_board = []
    @computer_board = []
  end

  def board_maker
    @board << gets.chomp.to_i
    @board << gets.chomp.to_i
    @board << gets.chomp.to_i
    @board << gets.chomp.to_i
    puts "Great! You have now made your board. Lets see if the computer can guess it!"
  end
  
  def lets_play
    puts "Great, the computer has 12 turns, it must guess the correct color combo. Enter your code. 1 means red, 2 means blue, 3 means green, 4 means yellow, 5 means purple, and 6 means taupe."
    sleep 1.5
    board_maker
    while true
      guess_checker
    end
  end  

  def board_generator
    @computer_board = []
    4.times do 
      @computer_board << (1..6).to_a.sample
    end
    puts "The Computer's guess is #{@computer_board}"
    sleep 2
  end
  
  def board_answer
    puts @board.to_s
  end 
  
  def exact_checker
    i = 0
    j = 1
    puts "This was turn number #{@turn_count}..."
    sleep 0.4
    @computer_board.each do |x|
      if x == @board[i]
        puts "#{x} in position #{j} is an exact match!"
      elsif @board.include?(x)
        puts "#{x} in position #{j} is close but not in the right position!"
      else
      end
      sleep 0.5
      i += 1
      j += 1
    end
  end
  
  def guess_checker
    turn_check
    board_generator
    if @board == @computer_board
      puts "You lose! The computer right at turn number #{@turn_count}."
      exit
    end
    past_guesses
    #board_answer
    exact_checker
    @turn_count += 1
  end
  
  def past_guesses
    @full_board << @computer_guess
    @full_board.each do |guesses|
      p guesses
    end
  end
  
  def turn_check
    if @turn_count > 12
      puts "Alright! you win! The computer could not guess it in time!"
      puts "Correct answer:"
      board_answer
      exit
    end
  end
end
