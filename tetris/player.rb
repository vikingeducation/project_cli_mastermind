class Player
  
  attr_reader :difficulty

  def initialize(board)
    @board = board
    @difficulty = 1
  end

  def welcome
    puts `clear`
    puts "WELCOME TO M-TRIS\n\n"
    puts "This is Michael Alexander's block-based puzzle game clone."
    puts "A to move left, D for right, S to drop the piece to the bottom."
    puts "No need to press Enter for these."
    puts "Your score will be DIFFICULTY x NUMBER OF ROWS CLEARED"
    puts "*" * 15
    gets
    set_difficulty
  end

  #prompt for move, send to Board
  def move
    direction = char_if_pressed
    @board.move(direction) if direction
  end



  def char_if_pressed
    begin
      state = `stty -g` #turn raw input on
      system `stty raw -echo -icanon isig`
      c = nil
      if $stdin.ready?
        c = $stdin.getc
      end
      c.chr if c
    ensure
      system  `stty #{state}` # turn raw input off
    end
  end


  private

  def set_difficulty
    puts "Enter your difficulty level (1-10): "
    input = gets.chomp.to_i

    @difficulty = input if input.between?(1,10)
  end

  #nonblocking version!!
  def char_if_pressed
    begin
      state = `stty -g` #turn raw input on
      `stty raw -echo -icanon isig`
      c = nil
      if $stdin.ready?  #nonblocking input check here
        c = $stdin.getc
      end
      c.chr if c
    ensure
      system  `stty #{state}` # turn raw input off
    end
  end

  #works on OSX and Linux not Windows
  #gets a char without pressing enter
  def enterless_input
    begin
      state = `stty -g`
      `stty raw -echo -icanon isig`

      input = STDIN.getc.chr
    ensure
      `stty #{state}`
    end
    input
  end




end
