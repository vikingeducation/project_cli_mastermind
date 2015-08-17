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

class Color
	include Paint

	attr_accessor :position, :number

	def initialize(options={})
		@number = options[:number]
		@position = options[:position]
	end

	def ==(other)
		@number == other
	end

	def to_s
		color(@number)
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

class Guess < Color
	attr_accessor :proximity

	def initialize(options={})
		super(
			:position => options[:position],
			:number => options[:color]
		)
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
			c = Guess.new(:position => i, :color => c)
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

	def sort
		@guesses.sort_by do |g|
		end
	end

	def dup
		guesses = @guesses.map {|g| g.number}
		self.class.new(:guesses => guesses)
	end

	def to_s
		lines = []
		sorted = @guesses.sort_by {|g| g.proximity}
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

class Board
	include Enumerable

	attr_accessor :code
	attr_reader :rows

	def initialize(options={})
		@rows = (1..12).to_a.map {Row.new}
		self.code = options[:code]
	end

	def code=(value)
		@code = Code.new(:colors => value)
	end

	def each(proc=nil)
		@rows.each do |item|
			if block_given?
				yield(item)
			else
				proc.call(item)
			end
		end
	end

	def [](index)
		@rows[index]
	end

	def <<(value)
		row = unresolved.first
		if row
			row << value
		end
		row
	end

	def to_s
		rows = []
		each_with_index do |r, i|
			rows << "#{i + 1}. "
			rows << r.to_s
			rows << '-' * Row::WIDTH
		end
		rows << @code.to_s
		rows.join("\n")
	end

	def resolve
		row = unresolved.first
		code_dup = @code.dup
		row_dup = row.dup
		exacts = exactness!(row_dup, code_dup)
		wrongs = wrongness!(row_dup, code_dup)
		wrongs -= exacts
		closes = closeness!(row_dup, code_dup)
		closes -= exacts
		results = {
			:exact => exacts,
			:close => closes,
			:wrong => wrongs
		}
		proximitize!(row, results)
		results
	end

	def unresolved
		select {|r| ! r.resolved?}
	end

	def resolved
		select {|r| r.resolved?}
	end

	def exactness!(row, code)
		exacts = row.select do |g|
			exact = (g == code[g.position])
			if exact
				code[g.position] = nil
			end
			exact
		end
		row -= exacts
		exacts
	end

	def closeness!(row, code)
		closes = row.select do |g|
			included = code.include?(g)
			if included
				removed = false
				code = code.map do |c|
					if c == g && ! removed
						c = nil 
						removed = true
					else
						c
					end
				end
			end
			included
		end
	end

	def wrongness!(row, code)
		wrongs = row.select {|g| ! code.include?(g)}
		row -= wrongs
		wrongs
	end

	def proximitize!(row, results)
		results.each do |key, value|
			value.each do |guess|
				row[guess.position].proximity = Proximity.new(:type => key)
			end
		end
		row = row.map {|g| g.proximity = Proximity.new(:type => :wrong) unless g.proximity}
	end

	def win?
		row = resolved.first
		@code == row
	end
end