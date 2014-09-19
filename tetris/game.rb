class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
    @scores = YAML.load(File.read("highscores.yaml"))
  end

  def start
    print_scores
    @player.welcome
    difficulty = @player.difficulty
    play
  end

  private

  def play
    loop do
      @board.render

      break if @board.swamped?

      sleep amount_set_by_difficulty

      @player.move

      #TODO: later, if nonblocking realtime, consider waiting a period of time here?
    end
    @board.render

    game_over
  end

  def game_over

    puts "Thanks for playing M-TRIS!"
    puts "Good job! Your score was #{my_score}!"

    if top_ten.any? {|entry| my_score > entry[1] }
      save_score
    end
  end

  def print_scores
    puts "WELCOME TO M-TRIS"
    puts "Top Ten Scores"

    0.upto(9) { |i| puts "#{i+1}\) #{top_ten[i][0]}\       #{top_ten[i][1]}\n" }
    puts "Press ENTER to see instructions and continue."
    gets
  end

  def my_score
    @board.lines_cleared * @player.difficulty
  end

  def save_score
    puts "WOW! You're in the high scores now!"
    print "Enter your name for posterity: "
    name = gets.chomp

    @scores << [name, my_score]
    File.open("highscores.yaml", 'w') { |file| file.write(YAML::dump(@scores)) }

    puts "Thanks, #{name}! Your score of #{my_score} will go down in history!"
  end

  #returns scores sorted top score to lowest
  def sorted_scores

    @scores.sort_by {|entry| -1 * entry[1] }
  end

  def top_ten
    sorted_scores[0..9]
  end

  #the number of seconds delay between turns
  def amount_set_by_difficulty
    1 - (Math::log10(@player.difficulty))
  end
end