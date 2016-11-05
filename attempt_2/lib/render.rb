class Render

  # Handles displaying information to CLI

  def self.welcome(colors, code_length)
    puts
    puts "Welcome to Mastermind!"
    puts "In this game, the Code maker sets a sequence of #{code_length} colors."
    puts "The colors are: #{colors}."
    puts "The code breaker's job is to guess the color sequence."
    puts "The code breaker only has twelve 12 chances!"
  end

  def self.show_turn(breaker_turns)
    puts
    puts "Turn: #{breaker_turns}"
  end

  def self.instructions(colors, code_length)
    puts "Enter #{code_length} letters from: #{colors}."
  end

  def self.game_board(results, guess)
    guess.split("").each { |color| print "|#{color}" }
    puts "|"
    puts "Exact Matches: #{results[:exact]}"
    puts "Near Matches: #{results[:close]}"
  end

  def self.win
    puts
    puts "Code has been deciphered!"
    puts
  end

  def self.lose
    puts
    puts "No more turns! Game over."
    puts
  end

end