require_relative './resources.rb'
#runs game
class MasterMind

  def initialize
    #players
    @player_1 = Human.build_codemaker #maker
    @player_2 = Human.build_codebreaker #breaker
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
    @player_1.get_and_set_role
    @player_2.set_role(@player_1.role)

    codebreaker, codemaker = nil, nil
    if @player_1.role == "codebreaker"
      codebreaker = @player_1
      codemaker = @player_2
    else
      codebreaker = @player_2
      codemaker = @player_1
    end

    # ask codemaker to create answer_key (if it's computer it'll be automatic, if player handle input)
    #codemaker.make_answer_key

    # start game loop here
      #print the board
      #ask codebreaker to make move (if it's computer it'll print)
      #commpare codebreaker guess to answer key
      #conditional:
        #if guess is correct, then print winner and break loop
        #else codemaker will print response (logic here), here print board with the codemaker response (his pegs)
    # end of loop
  end
end

a = MasterMind.new
a.play
