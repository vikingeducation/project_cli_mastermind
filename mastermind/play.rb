Dir[File.dirname(__FILE__)+'/*.rb'].each{ |f| require f }
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

 loop do
   puts "Enter the game number that you'd like to play:\n"
   puts "1)Computer generated code, player solves\n2)Player generated code, computer solves"
   choice=gets.chomp.to_i
   if (choice==1 || choice==2)
    Mastermind.new(choice)
    break
    end
  break
 end

