require './codebreaker.rb'
require './codemaker.rb'

puts "Would you like to play Mastermind as a codebreaker, or as a codemaker?"
user_input = gets.chomp.downcase

if user_input == "codebreaker"
  mastermind = Codebreaker.new
  mastermind.play
elsif user_input == "codemaker"
  mastermind = Codemaker.new
  mastermind.play
else
  puts "You didn't listen to me!"
end