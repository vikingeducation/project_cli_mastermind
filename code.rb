load 'configuration.rb'

class Code
  include Configuration
  attr_accessor :code

  def initialize(string)
    @code = string.split(//)
  end

  def last_letter
    (64 + NUMBER_OF_POSSIBLE_LETTERS).chr
  end

  def code_length
    CODE_LENGTH
  end

  def to_s
    code.join('')
  end

  def duplicates_allowed
    DUPLICATES_ALLOWED
  end
end

class ManualCode < Code
  def initialize
    puts "Enter a #{code_length}-character code using the letters A through #{last_letter}."
    puts "Duplicates are #{'not ' unless duplicates_allowed}allowed."
    input_is_valid = false
    until input_is_valid
      string = gets.chomp.upcase
      code_input = string.split(//)
      if validate_input(code_input)
        @code = code_input
        input_is_valid = true
      else
        puts "That is not a valid code."
      end
    end
  end

  def validate_input(code_input)
    all_letters_in_range(code_input) &&
    duplicate_analysis(code_input) &&
    correct_length(code_input)
  end

  def all_letters_in_range(code_input)
    code_input.all? { |letter| ("A"..last_letter).include? letter }
  end

  def duplicate_analysis(code_input)
    duplicates_allowed ||
    code_input == code_input.uniq
  end

  def correct_length(code_input)
    code_input.count == code_length
  end
end

class RandomCode < Code
  def initialize
    code = []
    until code.length == code_length do
      letter = generate_random_letter
      if duplicates_allowed || !(code.include? letter)
        code << letter
      end
    end
    @code = code
  end

  def generate_random_letter
    available_letters = ("A"..last_letter).to_a
    available_letters[ rand available_letters.count ]
  end
end