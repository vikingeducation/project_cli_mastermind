      guess_attempts = 4


    if guess_attempts > 0
      resume_phrase_1 = "back "
      resume_phrase_2 = "You have already had #{guess_attempts} guesses."
    else
      resume_phrase_1 resume_phrase_2 = ""
    end
    puts %{ 

      Welcome #{resume_phrase_1 }to Mastermind! Are you a champion?

      RULES: The codemaker creates a 4-digit code. Each digit 
      (representing a color) is in the range 1 - 6. 
      For example, "1234". The codebreaker has 12 guesses
      to crack the code. After that he/she loses. 
        
      After a guess the codebreaker will get this feedback:
      1. the guessed code
      2. number of black pegs
      3. number of white pegs
      
      Each black (or "exact") peg means you have guessed the
      right color and position of ONE of the code digits.
      Each white (or "close") peg means you have guessed the
      right color of ONE of the code digits but it is in ANOTHER
      position.
        
      #{resume_phrase_2} Let's begin!
    }     
