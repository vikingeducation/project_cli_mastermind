def fibonacci(number)
	fib_array=[0,1]
	counter=1
	(number-2).times do #already two numbers in the fib_array
		num=fib_array[counter]+fib_array[counter-1]
		counter+=1
		fib_array.push(num)
	end
	puts "Fibonacci sequence number #{number} is #{fib_array[number-1]}!"
	return fib_array[number];
end

fibonacci(101)