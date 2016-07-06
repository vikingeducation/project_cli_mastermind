#-------- have two players, in instance variables.--------------
# -----------consider calling them "codemaker" & "codebreaker"------------
# decide if each player is human or computer
# decide based on command line input
# fill in win and game over methods




class Game

  COLORS = %w[orange green red blue purple yellow]

  attr_accessor :player_guess, :secret_code

  def initialize
    @board = Board.new
    @secret_code = @board.generate_code
    @turns = 0
    @player_guess = []
  end
  
  def initialize_players
    puts "Do you want to be a code maker or a code breaker?"
    input = gets.chomp.downcase
    if input == "code maker"
      @code_maker = Human.new
      @code_breaker = Computer.new
    elsif input == "code breaker"
      @code_breaker = Human.new
      @code_maker = Computer.new
    else
      puts "Please enter either code maker or code breaker."
      initialize_players
    end
  end

  
  def play
    welcome_message
    initialize_players
    until lose? || win?
      increase_turns
      @player_guess = @code_breaker.get_move
      render
    end
    exit_message
  end



    
  end

  def render
    puts " #{@player_guess}"

  end


  def welcome_message
    puts "Welcome to Mastermind."
  end

  def exit_message
    puts "Thanks for playing Mastermind!"
  end

  def increase_turns 
    @turns += 1
  end



  def lose? 
    if @turns == 12 
      puts "You are out of turns."
      return true
    end
    false
  end

  def win? 
    if @player_guess == @secret_code
      puts "You solved the secret code."
      return true
    end
    false
  end

    
    



end