require './codebreaker.rb'
require './codemaker.rb'

puts "Welcome to Mastermind! The game where stuff gets cray! Do you want to play as a code breaker (type 'breaker') or code maker (type 'maker')?"
user_choice = gets.chomp
if user_choice.downcase == "breaker"
  new_game = Codebreaker.new
  new_game.lets_play
elsif user_choice.downcase == "maker"
  new_game = Codemaker.new
  new_game.lets_play
end