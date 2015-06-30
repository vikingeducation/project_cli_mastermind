
def check (code, answer)
  pegs=[]

  for i in (0..3) do
    puts answer[i]
    puts code[i]

    if answer[i]==code[i] 
      pegs << "black" 
    elsif code.any? {|color| color==answer[i]}
      pegs << "white" 
    else
      pegs << 0
    end
  end

  pegs

end


code = ["red","purple","purple","blue"]
answer= ["green","red","blue","purple"]

puts check(code, answer).inspect