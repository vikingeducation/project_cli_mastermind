class Compare
  attr_accessor :guess, :solution
  attr_writer :judge
  
  def init
    @guess = {}
    @solution = {}
  end
  
  def compare(guess,solution)
    both_r = 0
    elements_r = 0
    guess.split("").each_with_index.map { |value,index| @guess[index] = value }
    solution.split("").each_with_index.map { |value,index| @solution[index] = value }
    
    @guess.each do |index, value_gue|    
        both_r += 1 if @solution[index] == value_gue
    end
    
    elements_r = ( guess.split("") & solution.split("") ).length - both_r
    elements_r = 0 if elements_r < 0
    @judge = [elements_r, both_r]
    @judge
    
  end
  
end

class Input
  attr_writer :string
  
  def input_num
    puts "enter the ball colors you guess 1:RED 2:GREEN 3:BLUE 4:YELLOW 5:WHITE 6:BLACK"
    puts "enter you guess/want in the format of 1234, the number you enter should between 1111 and 6666"
    number = 0
    while number<1111 || number >6666 || !number.class == Fixnum do
        puts "unfollow the format will be asked to enter again"
        number = gets.chomp.to_i
    end
    @string = number.to_s
    @string
  end
  
end

class Filter
  attr_accessor :possible_guess
  
  def filt(array, judge, answer)
    @possible_guess = []
    c = Compare.new
    c.init
    array.each do |item|
      @possible_guess.push(item) if c.compare( item.to_s, answer) == judge
    end
    @possible_guess
  end
    
end

class MasterMind
  
  def game_start
    puts "what kind of game do you want to play"
    puts "enter A to let AI make a number to guess, enter B to make a problem for AI to solve"
    i = gets.chomp
    while (i != "A") && (i != "B") do
      print"you input is wrong"
      i = gets.chomp
    end
    case i
      when "B"
      play
      when "A"
      user_play
    end
  end 
  
  private  

  def play
    compare = Compare.new
    input = Input.new
    filt = Filter.new
    compare.init
    ans_group = Array(1111..6666).select { |item| (1..6).include?(item%10)&&(1..6).include?((item/100)%10)&&(1..6).include?((item/1000)%10)}
    num = input.input_num
    time = 0
    judge = [0,0]
    
    while judge != [0,4] && time<12 do
      current = ans_group.sample.to_s
      compare.init
      judge = compare.compare( current, num )
      ans_group = filt.filt(ans_group, judge, current)
      puts"my guess this time is #{current}"
      time += 1
      puts "this is the #{time} turns"
      puts judge
    end
    
    puts "AI will always win in 10 times"
  end
  
  def user_play
    compare = Compare.new
    input = Input.new
    compare.init
    answer = (Array(1111..6666).select { |item| (1..6).include?(item%10)&&(1..6).include?((item/100)%10)&&(1..6).include?((item/1000)%10)}).sample.to_s
    print answer
    puts ""
    guess = "0000"
    i = 0
    
    while compare.compare(guess,answer) != [0,4] do
      guess = input.input_num
      print"my guess is #{guess}        "
      i += 1
      puts "this is the #{i} turns"
      abort("you have running out of chances") if i >= 13
      print compare.compare(guess,answer)
      puts""
    end
    
    puts"you win"
    
  end
  
end


m = MasterMind.new
m.game_start
#print (Array (1111..6666))
#a = Input.new
#puts (a.input_num)
#set = Compare.new
#set.init
#print( set.compare("1315","1315") )
    