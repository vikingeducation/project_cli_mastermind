class Render
  def self.welcome(colors)
    puts "Welcome to Mastermind!"
    puts "In this game, the CodeMaker sets a sequence"
    puts "of 4 colors, from the colors #{colors}"
    puts "The CodeBreaker's job is to guess the color sequence"
    puts "in 12 turns or less"
  end

  def self.instuctions(colors)
    puts "enter 4 letters from: #{colors}"
  end

  def self.game_board(results, guess)
    guess.each { |color| print "|#{color}" }
    puts "|"
    puts "Exact Matches: #{results[:exact]}"
    puts "Near Matches: #{results[:near]}"
  end
end