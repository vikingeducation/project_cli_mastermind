class String

  def colourise
    col = { '1' => "\e[31m#{1}\e[0m",
            '2' => "\e[32m#{2}\e[0m",
            '3' => "\e[33m#{3}\e[0m",
            '4' => "\e[34m#{4}\e[0m",
            '5' => "\e[35m#{5}\e[0m",
            '6' => "\e[36m#{6}\e[0m",
            '7' => "\e[37m#{7}\e[0m",
            '8' => "\e[38m#{8}\e[0m",

            }
    colour = ''
    self.split(' ').each do |i|
      colour += " #{ col[i] } "
    end
    colour
  end
end
