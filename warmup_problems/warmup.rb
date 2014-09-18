#Warmup #1: Rolling Dice

#Write a method roll_dice which returns the result
#of rolling N 6-sided dice where N is the input to
#the method (the default should be 1). For example:

#> roll_dice(4)
#=> 18          # Rolled 4 dice
#> roll_dice(2)
#=> 4           # Rolled 2 dice
#> roll_dice
#=> 1           # Rolled 1 die

def roll(num=1)
  puts "You rolled #{num} dice. The total is: #{num*(1+rand(6))}" 
end



def doQuestionOne
  loop do
    puts "Type quit to exit.\nEnter the number of dice to roll: "
    numDice=gets.chomp
    break if numDice=='quit'
    roll(numDice.to_i)
  end
end

#=========================================================================
#Warmup #2: Rolling Dice Outcomes

#Now write a method dice_outcomes which takes the number of dice
#to roll and the number of times to roll them, then outputs a 
#visual chart of how many times each possible number comes up.
def dice_outcomes(num,times)
    output={}
    num.upto(num*6){|i| output[i]=0}
    times.times do |i|
        output[roll_dice(num)]+=1
    end
    output.sort.map do |k,v|
       puts (k < 10) ? "#{k}:  " + '#'*v : "#{k}: " + '#'*v  #ternary operator here used for formatting
    end
end

def roll_dice(num)
    total=0
    num.times do |i|
        total+=(1+rand(6)) #generate random roll 
    end
    total
end





def doQuestionTwo
  puts "Enter the number of dice to throw:"
  dice=gets.chomp
  puts "Enter the number of times to throw:"
  times=gets.chomp
  dice_outcomes(dice.to_i,times.to_i)
end


#=========================================================================
#Warmup #3: Fibonacci
#Write a method fibonacci which outputs the Fibonacci Sequence
#out to the specified number of digits. For example:
#> fibonacci(7)
#=> [1, 1, 2, 3, 5, 8, 11]

def fib(num)
    fibs=[1,1]
    return 0 if num == 0; return 1 if num == 1
    1.upto(num-2) do |i|
        prev,curr = fibs[-2],fibs[-1]
       fibs<<(prev+curr) 
    end
    p fibs    
end





def doQuestionThree
  puts "How many terms of the Fibonacci sequence do you want?"
  terms=gets.chomp
  fib(terms.to_i)
end



#=========================================================================
#Warmup #4: Stock Picker
#Write a method stock_picker which takes an array
#of stock prices (prices on days 0, 1, ...) and outputs 
#the most profitable pair of days on which to first buy
#the stock and then sell the stock, for example:
#> stock_picker([44, 30, 24, 32, 35, 30, 40, 38, 15]) 
#=> [2, 6]

def stock_picker(arr)
  max=0
  days=[]
  i,j=0,1
  while i<arr.length
    while j<arr.length
        if (arr[j]-arr[i]) > max
           max = arr[j]-arr[i]
           days[0],days[1]=i,j
        end
        j+=1
    end
    i+=1
    j=i+1
  end
  p days
end
def doQuestionFour
  puts "Using data:\n[44, 30, 24, 32, 35, 30, 40, 38, 15]"
  stock_picker([44, 30, 24, 32, 35, 30, 40, 38, 15])
end


#=========================================================================
#Warmup #5: Anagram Testing
#Write a method anagrams which returns an array of anagrams that can be 
#made with the specified string. Assume the input is only a single word
#(e.g. "loot" not "William Shakespeare").

#Example:
#> anagrams("looter")
# => ["RETOOL", "ROOTLE", "TOOLER"] 
#> anagrams("zygote")
#=> []

def anagrams(word)
  anagrams=[]
  f=File.open('dict.txt','r')
  f.each_line do |i|
    if i.chomp.length == word.length
      anagrams << i.chomp if word.chars.sort.join == i.chomp.chars.sort.join
    end
  end
  anagrams.delete_if {|i| i == word} #don't show the original word per the specs
  p anagrams
end


def doQuestionFive
  puts "Enter a word and this will show all anagrams:\n"
  word=gets.chomp
  anagrams(word.upcase)
end

#=========================================================================

#Wrapper method to be able to run any program at once
puts "Welcome to this awesome set of programs!"

  puts "Type quit to exit."
  puts "Choose the number of the program that you'd like to run:"
  puts "1)Rolling Dice\n2)Rolling Dice Outcomes\n3)Fibonacci"
  puts "4)Stock Picker\n5)Anagram Checker"

  choice = gets.chomp
  case choice
    when '1'
        doQuestionOne
    when '2'
        doQuestionTwo
    when '3'
        doQuestionThree
    when '4'
        doQuestionFour
    when '5'
        doQuestionFive
    else
        puts "Invalid input. What kind of shenanigans are you trying to pull!?"
  end