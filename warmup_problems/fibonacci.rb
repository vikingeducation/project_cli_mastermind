
def fibonacci(num)
	fib = [0,1]
	count = 0
	while fib.length < num do
		count+=1
		fib[count] = fib[count-1]+fib[count-2]
	end
	print fib
end
puts "How many fib nums you want?"
fib_nums_that_i_want = gets.chomp.to_i
puts fibonacci(fib_nums_that_i_want)