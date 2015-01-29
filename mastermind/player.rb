class Player
	attr_accessor :role, :guess 

	# @role
	@@colors=%w(red green yellow violet black white)
	def initialize (role)
		@role = role
		@guess=[]
	end

	def ask_for_guess
		i = 1
		4.times do
			puts "\nEnter guess for slot #{i}:"
			value = gets.chomp.downcase
			until validate_entry(value) do
				puts "Invalid Selection!\n You must select red, green, yellow, violet, black, or white:"
				value = gets.chomp.downcase
			end
			@guess.push(value)
			i+=1
		end
		@guess
	end

	def validate_entry(entry)
		@@colors.include?(entry)
	end

	def generate_code
		code = @@colors.sample(4)
		code
	end

	def manually_generate_code
		code=[]
		i = 1
		4.times do
			puts "Enter value for slot #{i} of code:"
			value = gets.chomp.downcase
			until validate_entry(value) do 
				puts "Invalid Selection!\n You must select red, green, yellow, violet, black, or white.\nPlease reenter: "
				value = gets.chomp
			end
			code.push(value)
			i+=1
		end
		code
	end
end