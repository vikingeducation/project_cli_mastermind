require 'rainbow'
require_relative 'correctitudable'
require_relative 'peg'
require_relative 'code'
require_relative 'computer'

class Game
  include Correctitudable

  GUESS_LIMIT = 12
  def initialize(cheat)
    @solution = Code.random
    @guesses = []
    @cheat_mode = cheat
  end

  def play
    puts Rainbow("WELCOME TO MASTERMIND").red
    if @cheat_mode
      puts "Here's the solution, you cheating bastard:"
      puts @solution.display
    end

    puts "CODEBREAKER or CODEMAKER?"
    if gets.chomp.downcase == "codebreaker"
      codebreaker_game
    else
      codemaker_game
    end
  end

  def codemaker_game
    computer = Computer.new
    puts
    ask_codemaker_input
      until game_over?
        puts

        guess = computer.next_guess
        @guesses << guess

        results = determine_correctitude(guess, @solution)
        puts display_guesses
        computer.purge_space(results)
        puts
      end

      if guess_correct?
        puts "What? The computer won??? And in only #{@guesses.count} guesses!"
        puts @solution.display
      elsif out_of_turns?
        puts "Mankind prevails! The computer is stupid and lost."
        puts @solution.display
      end
  end

  def codebreaker_game
      until game_over?
        puts
        ask_codebreaker_input
        puts
        puts display_guesses
      end

      if guess_correct?
        puts "You guessed correctly! The solution was indeed:"
        puts @solution.display
      elsif out_of_turns?
        puts "Sorry! You're out of turns. The code was:"
        puts @solution.display
      end
  end

  private

  def display_dots(correct_position, correct_color)
    output = []
    correct_position.times do
      output << Rainbow(".").red
    end
    correct_color.times do
      output << Rainbow(".").white
    end
    output.join(" ")
  end

  def display_guesses
    output = []
    @guesses.each do |guess|
      line = []
      line << guess.display
      results = determine_correctitude(guess, @solution)
      line << display_dots(*results)
      output << line.join("  ")
    end
    output.join("\n")
  end

  def ask_codemaker_input
    puts "Time to stump a random number generator."
    @solution = ask_player_input
  end

  def ask_codebreaker_input
    @guesses << ask_player_input
  end


  def ask_player_input
    loop do
      puts "Enter your code. (e.g. 1 2 3 4)"
      input = gets.chomp
      array = extract_numbers_from_string(input)
      unless valid_array?(array)
        puts Rainbow("Invalid guess! Enter 4 numbers between 1-6.").red
        next
      end
      return Code.from_array(array)
    end
  end

  def valid_array?(array)
    valid_range?(array) && valid_length?(array)
  end

  def valid_range?(array)
    array.all?{ |i| (1..6) === i }
  end

  def valid_length?(array)
    array.length == 4
  end

  def extract_numbers_from_string(string)
    string.scan(/\d/).map(&:to_i)
  end

  def game_over?
    out_of_turns? || guess_correct?
  end

  def out_of_turns?
    @guesses.count >= 12
  end

  def guess_correct?
    @guesses.any? { |guess| @solution == guess }
  end
end

Game.new(false).play
