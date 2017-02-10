require_relative 'board'
require_relative 'human'
require_relative 'machine'
MAKER = 1
BREAKER = 2

class Game
  def self.play
    human = Human.new
    machine = Machine.new(human.position)
    board = Board.new
    machine.greeting(human.name, machine.mach_pos)
    if human.position == BREAKER
      breaker = human
      maker = machine
    else
      breaker = machine
      maker = human
    end
    maker.create_code
    exit = false
    tries = 0
    while exit == false do
      breaker.guess
      tries +=1
      board.render(breaker.attempt)
      puts "That was attempt #{tries}"
      correct = maker.feedback(maker.code, breaker.attempt)
      if correct == 4
        puts "Codebreaker broke the codemakers code!"
        exit = true
      elsif tries == 12
        c = maker.code.join("  ")
        puts "Codebreaker did not break the code in 12 tries.  The code was #{c}"
        exit = true
      end
    end
  end

  # def self.win(code, attempt)
  #   attempt_arr = attempt.split("")
  #   exact = 0
  #   attempt_arr.each_with_index do |att_color, att_index|
  #     code.each_with_index do |cod_color, cod_index|
  #       if att_color[att_index] == cod_color[cod_index]
  #         exact += 1
  #       end
  #     end
  #   end
  #   return exact == 4
  # end

  # def self.lose(tries)
  #   return (tries == 12)
  # end
end

Game.play
