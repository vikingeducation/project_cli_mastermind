#new and improved Mastermind

module Mastermind

class Game
  attr_accessor :codemaker, :codebreaker, :board

  def initialize
    @board = Board.new
  end

  def start
    choose_sides
    get_code
    puts "The codemaker has just devised a secret code, 4 letters long, A-F. (Example: FBCA)."
    puts "Time to match wits against the machine!"
    12.times {take_turn}
    puts codebreaker.is_a?(Human) ? "Tragically, you have failed to break the code.":"Victory! The computer failed to outthink you!"
  end

  def choose_sides
    puts "Do you want to be the\nA) CODEMAKER \nor the \nB) CODEBREAKER?"
    print "(choose A or B): "
    answer = gets.chomp.upcase
    until answer == "A" || answer == "B"
     print "Try again. That's not an answer: "
     answer = gets.chomp.upcase
    end
    set_sides(answer)
  end

 def set_sides(answer)
   case answer
   when "A"
     @codemaker = Human.new
     @codebreaker = AI.new
   when "B"
     @codemaker = AI.new
     @codebreaker = Human.new
   end
 end

  def get_code
    codemaker.devise_code
  end

  def take_turn
    print "*** Press Enter To Take Your Turn ***"
    gets

    get_guess(codebreaker)
    get_response(codemaker)
    board.display
    declare_victory if won?

  end

  def get_guess(codebreaker)
    guess = codebreaker.guess(board)
    guess = "XXXX" unless guess.length == 4
    input_guess(guess)
  end

  def get_response(codemaker)
    guess = board.last_guess
    response = codemaker.respond(guess)
    input_response(response)
  end

  def input_guess(guess)
    board.input_guess(guess)
  end

  def input_response(response)
    board.input_response(response)
  end

  def won?
    board.last_response == "RRRR"
  end

  private

  def declare_victory
    if codebreaker.is_a?(Human)
      puts "Congratulations! You guessed it on turn #{board.last_turn}."
    else
      puts "Your clever code has been cracked on turn #{board.last_turn}."
      puts "Better luck next time!"
    end
      exit
  end

end

class Board

  def initialize
      @guesses = []
      @responses = []
  end

  def set_code(code)
    @code ||= code
  end

  def input_guess(row)
    @guesses << row
  end

  def input_response(row)
    @responses << row
  end

  def last_guess
    @guesses.last
  end

  def last_response
    @responses.last
  end


  def this_turn
    @guesses.size + 1
  end

  def last_turn
    @guesses.size
  end

  def display
    if this_turn == 1
      puts "No guesses yet."
    else
      (1..last_turn).each do |turn|
        print "Guess \##{turn}: "
        print @guesses[turn-1]
        print "   |  "
        print @responses[turn-1]
        puts "\n"
      end
    end
  end

end


class Player

  def respond(guess)
    response = "XXXX"

    @code_frequency = letters_count(@secret_code)
    @guess_frequency = letters_count(guess)
    r_count = Hash.new(0)

    mark_correct!(response, guess, r_count)
    mark_wrong_place!(response, guess, r_count)


    response

  end

  private

  def mark_correct!(response, guess, r_count)
    (0..3).each do |i|
      letter = guess[i]
      if @secret_code[i] == letter
        response[i] = "R"
        r_count[letter] += 1
      end
    end
  end

  def mark_wrong_place!(response, guess, r_count)
    (0..3).each do |j|
      letter = guess[j]
      next if letter == @secret_code[j]
      if @secret_code.include? letter
        response[j] = "W" if @guess_frequency[letter] > r_count[letter]
      end
    end
  end

  def letters_count(code)
    count = Hash.new(0)
    colors.each do |letter|
      count[letter] = code.count(letter)
    end
    count
  end


  def colors
    ["A", "B", "C", "D", "E", "F"]
  end
end

class AI < Player

  def initialize
    @best_guess = "XXXX"
  end

  # creates random code
  def devise_code
    code_string = ""
    4.times do
      letter = colors.sample
      code_string << letter
    end
    @secret_code = code_string
  end

  # ruthlessly cheesy algorithm that always wins on turn 7
  def guess(board)
    improve_guess(board) unless board.this_turn == 1

    case board.this_turn
    when 1
      return "AAAA"
    when 2
      return "BBBB"
    when 3
      return "CCCC"
    when 4
      return "DDDD"
    when 5
      return "EEEE"
    when 6
      return "FFFF"
    else
      return @best_guess
    end
  end

  private

  def improve_guess(board)

    (0..3).each do |index|
      if board.last_response[index] == "R"
        @best_guess[index] = board.last_guess[index]
      end
    end
  end
end #class

class Human < Player
  #only takes board to match ducktype of the AI version
  def guess(board)
    print "Take a guess (4 letters A-F, can repeat): "
    gets.chomp.upcase
  end

  def devise_code
     print "What's the secret code this time (4 letters A-F, can repeat letters)? "
     code_string = gets.chomp.upcase
     until code_string.length == 4 do
       print "That doesn't seem right. Try again: "
       code_string = gets.chomp.upcase
     end
     @secret_code = code_string
  end

end #class

end #module

include Mastermind
g = Game.new
g.start