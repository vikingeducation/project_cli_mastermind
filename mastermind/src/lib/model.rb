require_relative 'validation.rb'

class AppError < StandardError
	def initialize(message)
		super(message)
	end
end

class Model
	attr_reader :validation

	def initialize(options={})
		@validation = options[:validation] ? options[:validation] : Validation.new
		clear
	end

	def clear
	end
end
