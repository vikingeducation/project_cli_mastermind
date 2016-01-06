require 'rainbow'
require_relative 'peg'
require_relative 'code'
require_relative 'correctitudable'

class Game
  include Correctitudable

  GUESS_LIMIT = 12
  def initialize
    @solution = Code.random
    @guesses = []
  end

  def play
    puts @solution.display
    puts

    until game_over?
      ask_player_input
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

  # First we check for the position and color. Popping those values from
  # both arrays.

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
      line << determine_correctitude(guess)
      output << line.join("  ")
    end
    output.join("\n")
  end

  def ask_player_input
    loop do
      puts "Enter your code. (e.g. 1 2 3 4)"
      input = gets.chomp
      array = input.scan(/\d/).map(&:to_i)
      unless array.length == 4
        puts "Invalid guess. Must enter 4 numbers."
        next
      end
      unless array.all?{ |i| (1..6) === i }
        puts "Invalid guess. Numbers must be between 1-6."
        next
      end
      @guesses << Code.from_array(array)
      break
    end
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


Game.new.play

