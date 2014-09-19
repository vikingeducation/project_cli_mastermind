require './board'
require './attempt'
require './mastermindai'

class Mastermind
  def initialize
    @board = Board.new
    @attempts = 0
  end

  def play
    puts "Which role will you play?"
    puts "a. Codebreaker"
    puts "b. Codemaker"
    role = gets.chomp.downcase
    if role == 'a'
      codebreaker
    elsif role == 'b'
      puts "What will be the code (four letters, a through f)?"
      code = []

      until code.all? { |entry| ('a'..'f') === entry } && code.first && code.length == 4
        code = gets.chomp.downcase.split('')
      end

      @player = MastermindAI.new(@board)
      codebreaker(code, 'ai')
    else
      puts "Codebreaker"
      codebreaker(code=generate_code, 'ai')
    end
  end

  private

  def codebreaker(code=generate_code, player='human')
    guess = []
    @board.render
    while @attempts < 12 && guess != code
      if player == 'ai'
        guess = @player.ai_guess
      else
        guess = gets.chomp.downcase
        break if guess == 'quit' || guess == 'exit'
        guess = guess.split('')
      end

      if guess.all? { |entry| ('a'..'f') === entry } && guess.first && guess.length == 4
        accuracy = guess_evaluation(code, guess)
        @board.render(guess, accuracy)
      else
        puts "Invalid guess"
      end
    end
    @board.render(code, accuracy) if @attempts == 12
  end

  def guess_evaluation(code, guess)
    attempt = Attempt.new
    @attempts += 1
    attempt.check_accuracy(code, guess)
  end

  def generate_code
    (1..4).map { ('a'..'f').to_a[rand(6)] }
  end
end

game = Mastermind.new
game.play