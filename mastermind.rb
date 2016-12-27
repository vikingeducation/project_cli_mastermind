require './string'
require './board'
require './player'
require './human'
require './computer'
require 'pry'

class Mastermind 
  def initialize
    play
  end

  private

  def play
    display_welcome
    display_game_rules
    ask_if_ready
    ask_how_many_games_to_play
    ask_for_game_mode 
    ask_for_nickname if @player1.class == Human  # ?
    
    i = 1
    while i <= @num_games do
      @board = Board.new
      get_code_for_this_game
      display_relevant_code_msg
      puts
      display_game_is_starting(i, @num_games)
      display_players_names_and_roles(@player1, @player2)
      @board.render_board
      puts 
      if @player1.current_role > 0
        guess_num = ask_for_guess(@player2)
      else
        guess_num = ask_for_guess(@player1)
      end
      display_guess_and_points_info(guess_num)   
      i += 1
    end
    display_winner
    puts
    quit_game
  end

  def display_welcome
    puts "Welcome to Mastermind!"
    puts "You can quit the program at anytime by entering 'q'."
    puts
  end

  def display_game_rules
    puts "~ Game rules:"
    puts "You can play as either the codemaker or the codebreaker."
    puts "The codemaker chooses a pattern of four code pegs - order matters!"
    puts "Duplicates are allowed (code pegs of same color can be chosen multiple times)."
    puts "There are 6 code pegs: red, green, yellow, blue, magenta, and cyan."
    puts "The codebreaker tries to guess the pattern, in both order and color, within 12 turns."
    puts "After each guess, feedback is provided via key pegs."
    puts "A gray key peg indicates a guess of correct color code but wrong position."
    puts "A red key peg indicates a guess that is correct in both color and position."
    puts "~ Scoring:"
    puts "The number of games is decided in advance, and must be an even number."
    puts "Players switch roles for each game."
    puts "The codemaker gets 1 point for each guess a codebreaker makes."
    puts "An extra point is earned by the codemaker if the codebreaker doesn't guess the pattern"
    puts "exactly in the last guess."
    puts "The winner is the one with the most points after the agreed-upon # of games are played."
    puts
  end

  def ask_if_ready
    puts "Are you ready to play? (y|n)"
    input = gets.chomp
    until input == 'y'
      quit_game if input == 'n' || input == 'q'
      puts "Please enter 'y' or 'n'."
      input = gets.chomp
    end
  end

  def ask_how_many_games_to_play
    puts "How many games do you want to play -"
    puts "Please enter an even number (min: 2, max: 20):"
    input = gets.chomp
    until input.to_i.even? && input.to_i <= 20 && input.to_i >= 2
       quit_game if input == 'q'
      puts "Please enter an even number between 2 and 20."
      input = gets.chomp
    end
    @num_games = input.to_i
  end

  def ask_for_game_mode
    puts "Please select a game mode:"
    puts "1) Play starting as codemaker vs AI."
    puts "2) Play starting as codebreaker vs AI."
    puts "3) Watch 2 AI's battle it out!"
    input = gets.chomp
    until %w(1 2 3).include?(input)
      quit_game if input == 'q'
      puts "Please enter 1, 2, or 3!."
      input = gets.chomp
    end
    create_players(input)
  end

  def create_players(input)
    case input
    when '1'
      @player1 = Human.new(1)    # 1 => codemaker
      @player2 = Computer.new(-1)  # -1 => codebreaker
    when '2'
      @player1 = Human.new(-1)
      @player2 = Computer.new(1)
    when '3'
      @player1 = Computer.new(1)
      @player2 = Computer.new(-1)
    end
  end

  def ask_for_nickname
    puts "Please enter a nickname (10 characters max):"
    input = gets.chomp
    until input.length <= 10
      puts "Nickname must be 10 characters or less!"
      input = gets.chomp
    end
    quit_game if input == 'q'
    @player1.name = input
  end

  def display_game_is_starting(game_num, total_num_games)
    puts "Get ready! Game #{game_num} of #{total_num_games} is starting now..."
  end

  def display_players_names_and_roles(player1, player2)
    puts "#{player1.name} (#{role_in_words(player1.current_role)}) vs. #{player2.name} (#{role_in_words(player2.current_role)})"
    puts
  end

  def role_in_words(role)
    role > 0 ? 'codemaker' : 'codebreaker'
  end

  def get_code_for_this_game
    if @player1.current_role > 0
      @board.current_code = @player1.make_code 
      @board.current_codemaker = @player1
    else
      @board.current_code = @player2.make_code
      @board.current_codemaker = @player2
    end
  end

  def display_relevant_code_msg
    if @player1.class == @player2.class 
      @board.render_code 
    elsif @board.current_codemaker.class == Computer
      puts "#{@board.current_codemaker.name} has selected a code!"
    else
      @board.render_code  
    end
  end 

  def ask_for_guess(player)
    puts "#{player.name}'s turn to break the code:"
    guess_num = 1 
    feedback = nil
    while guess_num <= 12 do 
      guess_array = player.guess(guess_num, feedback)
      feedback = @board.update_board!(guess_array, guess_num)
      @board.render_board
      break if feedback[:red] == 4
      guess_num += 1
    end
    guess_num
  end

  def display_guess_and_points_info(guess_num)
    if @player1.current_role > 0
      @player1.points += guess_num
      display_relevant_guess_msg(@player2.name, guess_num)
      puts "#{@player1.name} has earned #{guess_num} points! (#{@player1.points} total points)"
      puts
      switch_roles
    else
      @player2.points += guess_num
      display_relevant_guess_msg(@player1.name, guess_num)
      puts "#{@player2.name} has earned #{guess_num} points! (#{@player2.points} total points)"
      puts
      switch_roles
    end
  end

  def display_relevant_guess_msg(player_name, guess_num)
    if guess_num < 13
      puts "#{player_name} has broken the code in #{guess_num} guesses!" 
    else
      puts "#{player_name} has failed to guess the code in 12 tries!"
    end
  end

  def switch_roles
    @player1.current_role *= -1
    @player2.current_role *= -1
  end

  def display_winner
    if @player1.points > @player2.points 
      puts "#{@player1.name} wins with a score of #{@player1.points}-#{@player2.points}!"
    elsif @player1.points < @player2.points 
      puts "#{@player2.name} wins with a score of #{@player2.points}-#{@player1.points}!"
    else
      puts "It's a tie score: #{@player1.points}-#{@player2.points}!"
    end
  end

  def quit_game
    puts "Thanks for playing!"
    puts "Exiting now..."
    exit
  end
end

# Mastermind.new

