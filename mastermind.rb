class Mastermind
  # intro
  # let user enter his name -- @player_name
  # Generate the correct answer -- @correct_answer
  # let user enter his choice -- @player_answers
  # loop certain rounds - can be customized -- @round
  # Validate the answers
  # check the solution
  # win if the answer match
  # provide hint if the answer is incorrect -- @hint_list
  # render display
  # Next round
  COLOR = %w(r g b y o)

  def initialize(player_name, round)
    @round = round
    @player = Player.new(player_name)
    @display = Display.new
    @hint_list = []
    @player_answers = []
    @correct_answer = []
  end

  def start
    print COLOR
    intro
    generate_correct_answer
    @round.times do |n|
      # loop goes here
      puts "#{n + 1} round"
      @current_answer = @player.get_answer
      @player_answers << @current_answer
      if !validate
        puts "Your input is incorrect! You waste a round!"
        @display.render(@hint_list, @player_answers)
      else
        if win
          puts "Congratulation! You win!"
        else
          generate_hint
          puts "You lose this round"
          @display.render(@hint_list, @player_answers)
        end
      end
      @current_answer = ""
    end
    puts "The Game is over and you lose :( The correct answer should be #{@correct_answer}"
  end

  def intro
    puts "Welcome to the mastermind game! #{@player_name}!"
    puts "Please pick a color from red, green, blue, yellow, orange for each slot"
    puts "You will win if you guess the correct sequence. Hints will be provided!"
  end

  def generate_correct_answer
    4.times  do
      @correct_answer << COLOR.sample      
    end
  end

  def validate
    if @current_answer.length != 4
      return false
    end
    @current_answer.each do |one_answer|
      if !COLOR.include? one_answer
        return false
      end
    end
    return true
  end

  def win
    if @current_answer == @correct_answer
      return true
    end
    return false
  end

  def generate_hint
    temp = []
    c = 0
    pc = 0
    w = 0
    @current_answer.each_with_index do |one_current_ans, i|
      if one_current_ans == @correct_answer[i]
        c += 1
      elsif @correct_answer.include? one_current_ans
        pc += 1
      else
        w += 1
      end
    end
    temp << c << pc << w
    @hint_list << temp
  end
end

class Player
  attr_reader :player_name

  def initialize(player_name)
    @player_name = player_name
  end

  def get_answer
    puts "Please guess:"
    answer = gets.chomp.downcase.split(',')
    return answer
  end
end

class Display
  def render(hint_list, player_answers)
    hint_list.length.times do |n|
      print "#{player_answers[n]} **** Correct:#{hint_list[n][0]} *** partly Correct:#{hint_list[n][1]} *** Incorrect:#{hint_list[n][2]}"
      puts ""
    end
  end
end

mastermind = Mastermind.new("Bill", 5)
mastermind.start