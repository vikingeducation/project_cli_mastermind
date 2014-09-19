 require 'io/wait'

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
      system  "stty #{state}" # turn raw input off
    end
  end

  while true
    c = char_if_pressed
    puts "[#{c}]" if c
    sleep 1
    puts "tick"
  end