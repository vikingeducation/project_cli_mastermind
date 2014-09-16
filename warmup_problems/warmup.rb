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
loop do
  puts "Type quit to exit.\nEnter the number of dice to roll: "
  numDice=gets.chomp
  break if numDice=='quit'
  roll(numDice.to_i)
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

dice_outcomes(3,100)


#=========================================================================
#Warmup #3: Fibonacci
#Write a method fibonacci which outputs the Fibonacci Sequence
#out to the specified number of digits. For example:
#> fibonacci(7)
#=> [1, 1, 2, 3, 5, 8, 11]

def fib(num)
    fibs=[1,1]
    return 0 if num == 0
    return 1 if num == 1
    1.upto(num-2) do |i|
        prev,curr = fibs[-2],fibs[-1]
       fibs<<(prev+curr) 
    end
    fibs    
end
fib(7)



#=========================================================================
#Warmup #4: Stock Picker
#Write a method stock_picker which takes an array
#of stock prices (prices on days 0, 1, ...) and outputs 
#the most profitable pair of days on which to first buy
#the stock and then sell the stock, for example:
#> stock_picker([44, 30, 24, 32, 35, 30, 40, 38, 15]) 
#=> [2, 6]



