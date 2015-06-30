def deep_dup(arr)
  new_arr = []

arr.each do |top|

  top.each do |item|

      new_arr[top][0] = item
      p top
      p new_arr
    
    p ("Item is #{item}")
    p ("Top is #{top}")


    # p top
  end

end
  new_arr 
end

=begin
def depth (a)
  return 0 unless a.is_a?(Array)
  result = 1
  a.each do(sub)
    if sub.is_a? (Array)
    dimension = 
end

> depth(arrA)
=> 3
=end

arr = [[1,2],[3,4]]

copy = deep_dup(arr)

p arr

p copy