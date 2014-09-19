Dir[File.dirname(__FILE__)+'/*.rb'].each{ |f| require f } #include all ruby files in this script
 puts "Welcome to MasterMind!"
 puts ""
 puts "You must guess the"\
 " secret code in 12 turns or less.  The code is a"\
 " 4 item combination of letters, ranging from A-F"\
 "(Ex: ABCD, AACF, FEAB), etc."
 puts " "
 puts "If you guess the correct letter in the wrong place, "\
 "you will get a \"W\" (wrong).  If you guess the correct letter "\
 "in the correct place, you will get a \"R\" (right).  Good luck!"
 puts " "
def player_loop
 loop do
   puts "Enter the game number that you'd like to play:\n"
   puts "1)Computer generated code, player solves\n2)Player generated code, computer solves"
   choice=gets.chomp.to_i
    return choice if (choice==1 || choice==2)
 end
end

  Mastermind.new(player_loop)



  #===========SAMPLE OUTPUT 1 =============#
  #Computer generates code. Player guesses:
  #Enter the game number that you'd like to play:
#1)Computer generated code, player solves
#2)Player generated code, computer solves
#1
#You have 12 turns remaining! Enter your guess: 
#aabb
#Guess: AABB        Result: []
#You have 11 turns remaining! Enter your guess: 
#cccc
#Guess: CCCC        Result: ["W", "R", " ", " "]
#You have 10 turns remaining! Enter your guess: 
#dddd
#Guess: DDDD        Result: ["R", " ", "W", " "]
#You have 9 turns remaining! Enter your guess: 
#eeee
#Guess: EEEE        Result: ["W", " ", "R", "R"]
#You have 8 turns remaining! Enter your guess: 
#ffff
#Guess: FFFF        Result: []
#You have 7 turns remaining! Enter your guess: 
#ccde
#Guess: CCDE        Result: ["W", "R", " ", "R"]
#You have 6 turns remaining! Enter your guess: 
#ecee
#Guess: ECEE        Result: ["W", "R", "R", "R"]
#You have 5 turns remaining! Enter your guess: 
#ccee
#Guess: CCEE        Result: ["W", "R", "R", "R"]
#You have 4 turns remaining! Enter your guess: 
#bcee
#Guess: BCEE        Result: ["R", "R", "R"]
#You have 3 turns remaining! Enter your guess: 
#acee
#Guess: ACEE        Result: ["R", "R", "R"]
#You have 2 turns remaining! Enter your guess: 
#fcee
#Guess: FCEE        Result: ["R", "R", "R"]
#You have 1 turns remaining! Enter your guess: 
#dcee
#You win!
#You guessed the correct code in 12 turns!
#The code was DCEE.


  #===========SAMPLE OUTPUT 2=============#
  #Player generates code. AI Guesses:
#  Enter the game number that you'd like to play:
#1)Computer generated code, player solves
#2)Player generated code, computer solves
#2
#Pick your super secret code and see if the AI can guess it! (ex AAAA, ABCD)
#aabb
#your code is AABB
#The AI guessed ECBF.
#Guess:         Result: ["R"]
#The AI guessed ADFC.
#Guess:         Result: ["R"]
#The AI guessed AFDA.
#Guess:         Result: ["R", "W"]
#The AI guessed AEDF.
#Guess:         Result: ["R"]
#The AI guessed AEDA.
#Guess:         Result: ["R", "W"]
#The AI guessed AFAA.
#Guess:         Result: ["R", "W", " "]
#The AI guessed AADF.
#Guess:         Result: ["R", "R"]
#The AI guessed AACA.
#Guess:         Result: ["R", "R", " "]
#The AI guessed AABB.
#You win!
#You guessed the correct code in 9 turns!
#The code was AABB.