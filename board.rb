class Board

  def initialize
    @complete = {}
    @guess_num = nil
  end
    
  def update_with(latest)
    @guess_num = latest[0]
    unless @guess_num > 9
      @guess_num = @guess_num.to_s.split("").unshift(0).join("")
    end
    @complete[@guess_num] = latest[1]
  end

  def render(latest)
    update_with(latest)
    visualize
    code_cracked?
  end

  def visualize
    puts "\n******************************************************"
    puts "|   Guess #  |   Guess Content   |      Feedback     |"
    puts "******************************************************"
    @complete.each do |key, value|
      print "|     #{key}     "
      print "|   #{value[0].join(" - ")}   "
      puts "|   #{value[1].join(" - ")}   |"
      unless key == @guess_num
        print "|"
        52.times { print "-" }
        puts "|"
      end
    end
    puts "******************************************************\n\n"
  end

  def code_cracked?
    if $guess.winning? && $player.class == Codebreaker
      $player.won(@guess_num)
    elsif $guess.winning? && $player.class == Codemaker
      $player.lost(@guess_num)
    elsif @guess_num == 12 && $player.class == Codebreaker
      $player.lost
    elsif @guess_num == 12 && $player.class == Codemaker
      $player.won
    else
      return false
    end
  end

end