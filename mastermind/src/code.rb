require_relative 'color.rb'

class Code
	include Enumerable

	attr_accessor :colors

	def initialize(options={})
		if options[:colors]
			self.colors = options[:colors] if options[:colors]
		else
			clear
		end
	end

	def clear
		@colors = (0..3).to_a.map {|i| Color.new(:position => i)}
	end

	def ==(other)
		self.normalize == other.normalize
	end

	def normalize
		self.map {|c| "#{c.position}.#{c.number}"}.join("-")
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

class Row < Code
	WIDTH = Paint::WIDTH * 7 + 3

	def initialize(options={})
		if options[:colors]
			self.colors = options[:colors] if options[:colors]
		else
			clear
		end
	end

	def clear
		@colors = (0..3).to_a.map {|i| Guess.new(:position => i)}
	end

	def colors=(value)
		@colors = value.map.with_index do |c, i|
			c = Guess.new(:position => i, :number => c)
		end
	end

	def sort_by_proximity
		sort_by do |g|
			g.proximity
		end
	end

	def to_s
		lines = []
		sorted = sort_by_proximity
		2.times do |i|
			line = map {|c| c.to_s}.join
			color1 = sorted[0 + (2 * i)]
			color2 = sorted[1 + (2 * i)]
			proximity1 = color1.proximity ? color1.proximity : ' ' * Paint::WIDTH
			proximity2 = color2.proximity ? color2.proximity : ' ' * Paint::WIDTH
			line += " | [#{proximity1}][#{proximity2}]"
			lines << line
		end
		lines.join("\n")
	end

	def resolved?
		! select {|g| g.proximity}.empty?
	end
end
