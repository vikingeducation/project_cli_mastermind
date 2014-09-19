def roll_dice(num=1)
	arr = Array.new(num){(rand(6)+1)}
	# print "#{arr}" + "\n"
	puts arr.reduce(:+)
end

puts "Number of dice?"
dice = gets.chomp.to_i

roll_dice(dice)