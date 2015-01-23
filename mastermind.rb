#!/usr/bin/ruby
# encoding: utf-8

require './pegset.rb'
require './code.rb'
require './configuration.rb'
require './donald.rb'

class MastermindGame
  attr_reader :code_length, :number_of_turns, :past_turns, :master_code, :human_player

  def initialize
    set_instance_variables
    player_orientation
    # initialize_donald
    until game_over? do
      take_a_turn
    end
    game_ending_sequence
    nil
  end

  def set_instance_variables
    @code_length = Configuration::CODE_LENGTH
    @number_of_turns = Configuration::NUMBER_OF_TURNS
    @past_turns = []
    @master_code = RandomCode.new
  end

  def player_orientation
    print intro_message
    input_valid = false
    until input_valid
      input = gets.chomp.upcase
      if input == "B"
        @human_player = true
        input_valid = true
      elsif input == "M"
        @human_player = false
        input_valid = true
      else
        print "Please enter 'B' or 'M'.\n > "
      end
    end
  end

  def intro_message
    "\nWELCOME TO MASTERMIND\nDo you have what it takes to break the code?\n\nHow would you like to play?\nas CODE BREAKER: 'B'\nas CODE MAKER:   'M'\n > "
  end

  # def initialize_donald
    # @donald = Donald.new
  # end

  def take_a_turn
    player_code = turn_code
    pegs = PegSet.new(turn_scorer player_code)
    past_turns << { code: player_code, pegs: pegs }
    print_game_board
  end

  def turn_code
    if human_player
      ManualCode.new
    else
      RandomCode.new # @donald.ask(past_turns)
    end
  end

  def turn_scorer(player_code)
    scores = {}
    scores[:exactly_matched] = count_exact_matches(player_code)
    scores[:partially_matched] = count_partial_matches(player_code)
    scores[:unmatched] = count_unmatched_letters(scores)
    scores
  end

  def game_ending_sequence
    if human_player
      code_breaker_ending
    else
      code_maker_ending
    end
    puts "GAME OVER"
  end

  def code_breaker_ending
    if past_turns[-1][:pegs].winning?
      puts "CONGRATULATIONS! You broke the code in #{past_turns.count} tries."
    else
      puts "Sorry, you did not break the code."
    end
  end

  def code_maker_ending
    if past_turns[-1][:pegs].winning?
      puts "Sorry, Donald was able to break your code in #{past_turns.count} tries."
    else
      puts "Congratulations, Donald could not break your code."
    end
  end

  def count_exact_matches(player_code)
    exact_matches = 0
    player_code.code.each_with_index do |letter, index|
      if letter == master_code.code[index]
        exact_matches += 1
      end
    end
    exact_matches
  end

  def count_partial_matches(player_code)
    all_matches = 0
    player_code.code.each do |letter|
      if master_code.code.include? letter
        all_matches += 1
      end
    end
    all_matches - count_exact_matches(player_code)
  end

  def count_unmatched_letters(scores)
    code_length - scores[:exactly_matched] - scores[:partially_matched]
  end

  def print_game_board
    puts ""
    print_past_turns
    print_remaining_turns
    print_final_line
    puts ""
  end

  def print_past_turns
    past_turns.each do |turn|
      puts "#{turn[:code]}  #{turn[:pegs]}"
    end
  end

  def print_remaining_turns
    (number_of_turns - past_turns.count).times do
      puts "-" * code_length
    end
  end

  def print_final_line
    if game_over?
      print master_code
    else
      print "?" * code_length
    end
    puts " <= CODE"
  end

  def game_over?
    return false if past_turns.empty?
    last_pegset = past_turns[-1][:pegs]
    last_pegset.winning? || past_turns.count == number_of_turns
  end
end

# game = MastermindGame.new