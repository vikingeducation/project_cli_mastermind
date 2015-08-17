module Paint
	WIDTH = 4

	def color(number)
		code = ((number.to_i % 15)).to_s
		bg = "\e[48;5;#{code}m"
		width = ' ' * WIDTH
		close = "\e[0m"
		"#{bg}#{width}#{close}"
	end
end

class Proximity
	include Paint

	attr_accessor :type

	def initialize(options={})
		@type = options[:type]
	end

	def ==(value)
		@type == value
	end

	def to_s
		@type ? send(@type) : wrong
	end

	def <=>(other)
		if @type == other.type
			return 0
		elsif @type == :exact
			return -1
		elsif @type == :close && other.type == :wrong
			return -1
		elsif @type == :close && other.type == :exact
			return 1
		elsif @type == :wrong	
			return 1
		end
	end

	private
		def close
			color(7)
		end

		def exact
			color(8)
		end

		def wrong
			color(0)
		end
end

class Color
	include Paint

	attr_accessor :position, :number

	def initialize(options={})
		@number = options[:number]
		@position = options[:position]
	end

	def ==(other)
		@number == other.number
	end

	def to_s
		color(@number)
	end
end

class Guess < Color
	attr_accessor :proximity

	def proximity=(value)
		@proximity = Proximity.new(:type => value)
	end

	def exact?
		@proximity == :exact
	end

	def close?
		@proximity == :close
	end

	def wrong?
		@proximity == :wrong
	end
end