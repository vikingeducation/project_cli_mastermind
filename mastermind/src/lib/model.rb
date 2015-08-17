class AppError < StandardError
	def initialize(message)
		super(message)
	end
end

class Model
	attr_reader :auth

	def initialize(options={})
		@auth = options[:auth] ? options[:auth] : Auth.new
		clear
	end

	def clear
	end
end
