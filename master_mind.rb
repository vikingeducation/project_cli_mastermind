require_relative './resources.rb'
#runs game
class MasterMind

  def initialize

    #game_board
    @board = GameBoard.new
  end

  def print_intro
    puts
    puts "Welcome to Mastermind!"
    puts "Pick your opponent: Human or Computer."
    puts "Pick your role: Codemaker or Codebreaker"
    puts
  end

  def play
    print_intro
    @board.render

    #ask user for roles and sets them appropriately
    player_1 = Human.new
    player_2 = Human.new

    codebreaker, codemaker = nil, nil
    if player_1.get_and_set_role == "codebreaker"
       player_2.set_role(player_1.role)
      codebreaker = player_1
      codemaker = player_2
     else
      player_2.set_role(player_1.role)
      codebreaker = player_2
      codemaker = player_1
    end

    # puts "Player #{player_1.role}, Player2 #{player_2.role}"

    # ask codemaker to create answer_key (if it's computer it'll be automatic, if player handle input)
    #codemaker.make_answer_key
    #if player is computer
    #  generate the answer_key
    # else
    #  get the answer_key
    #

     @board.set_answer_key(codemaker.get_color_pegs)
     #puts @board.answer_key.inspect

     guess_counter = 0
     max_guesses = 12
     while guess_counter < max_guesses
      #print board
      @board.render
      #ask for guess
      guess = codebreaker.get_color_pegs
      #update board assuming valid guess
      @board.set_pegs(guess_counter, guess)
      #compare guess with answer key
      if @board.compare(guess_counter, guess)
        puts "win!"
        break
      else
        codemaker_response
      end
      #reprint with updated guess
      @board.render

     end
    # start game loop here
      #print the board
      #ask codebreaker to make move (if it's computer it'll print)
      #if valid move > save onto board
      #commpare codebreaker guess to answer key
      #conditional:
        #if guess is correct, then print winner and break loop
        #else codemaker will print response (logic here), here print board with the codemaker response (his pegs)
    # end of loop
  end
end

a = MasterMind.new
a.play
