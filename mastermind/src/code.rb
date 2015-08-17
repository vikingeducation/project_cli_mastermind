require_relative 'color.rb'

module Pattern
	def ==(other)
		self.normalize == other.normalize
	end

	def normalize
		self.map {|c| "#{c.position}.#{c.number}"}.join("-")
	end
end

class Code
	include Enumerable
	include Pattern

	attr_accessor :colors

	def initialize(options={})
		if options[:colors]
			self.colors = options[:colors] if options[:colors]
		else
			@colors = (0..3).to_a.map {|i| Color.new(:position => i)}
		end
	end

	def [](index)
		@colors[index]
	end

	def []=(index, value)
		@colors[index] = value
	end

	def <<(value)
		color = select {|c| ! c.number}.first
		color.number = value if color
	end

	def -(value)
		@colors - value
	end

	def dup
		colors = @colors.map {|c| c.number}
		self.class.new(:colors => colors)
	end

	def colors=(value)
		@colors = value.map.with_index do |c, i|
			c = Color.new(:position => i, :number => c)
		end
	end

	def each(proc=nil)
		@colors.each do |item|
			if block_given?
				yield(item)
			else
				proc.call(item)
			end
		end
	end

	def to_s
		lines = []
		2.times do
			line = @colors ? self.map {|c| c.to_s}.join : ''
			lines << line
		end
		lines.join("\n")
	end
end

class Row
	WIDTH = Paint::WIDTH * 7 + 3

	include Enumerable
	include Pattern

	attr_accessor :guesses

	def initialize(options={})
		if options[:guesses]
			self.guesses = options[:guesses] if options[:guesses]
		else
			@guesses = (0..3).to_a.map {|i| Guess.new(:position => i)}
		end
	end

	def guesses=(value)
		@guesses = value.map.with_index do |c, i|
			c = Guess.new(:position => i, :number => c)
		end
	end

	def [](index)
		@guesses[index]
	end

	def <<(value)
		guess = select {|g| ! g.number}.first
		guess.number = value if guess
	end

	def -(value)
		@guesses - value
	end

	def each(proc=nil)
		@guesses.each do |item|
			if block_given?
				yield(item)
			else
				proc.call(item)
			end
		end
	end

	def sort_by_proximity
		sort_by do |g|
			g.proximity
		end
	end

	def dup
		guesses = map {|g| g.number}
		self.class.new(:guesses => guesses)
	end

	def to_s
		lines = []
		sorted = sort_by_proximity
		2.times do |i|
			line = map {|c| c.to_s}.join
			g1 = sorted[0 + (2 * i)]
			g2 = sorted[1 + (2 * i)]
			p1 = g1.proximity ? g1.proximity : ' ' * Paint::WIDTH
			p2 = g2.proximity ? g2.proximity : ' ' * Paint::WIDTH
			line += " | [#{p1}][#{p2}]"
			lines << line
		end
		lines.join("\n")
	end

	def resolved?
		! select {|g| g.proximity}.empty?
	end
end
