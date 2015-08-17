require_relative 'code.rb'

class Board
	include Enumerable

	attr_accessor :code, :role, :debug
	attr_reader :rows

	def initialize(options={})
		@debug = options[:debug]
		@role = options[:role]
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
		rows << @code.to_s if show_code?
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
				row[guess.position].proximity = key
			end
		end
		row = row.map {|g| g.proximity = wrong unless g.proximity}
	end

	def code?
		@code.select {|c| ! c.number}.empty?
	end

	def win?
		row = resolved.first
		row ? @code == row : false
	end

	def lose?
		unresolved.empty? && ! win?
	end

	def resolve_ready?
		row = unresolved.first
		row.select {|g| ! g.number}.empty? && code?
	end

	private
		def show_code?
			return true if @debug
			if @role == :codebreaker
				return true if win? || lose?
			elsif @role == :codemaker
				return true
			end
			return false
		end
end