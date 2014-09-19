

def enterless_input
  begin
    state = `stty -g`
    `stty raw -echo -icanon isig`

    input = STDIN.getc.chr
  ensure
    `stty #{state}`
  end
  p input
end
