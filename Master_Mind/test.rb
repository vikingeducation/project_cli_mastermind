a= {'1' => 0, '2' => 0}
b= ['1', '2', '3', '4']
c= {}


b.each do |key|
  if !(a.keys.include? key)
    c[key] = []
  end
end

print c