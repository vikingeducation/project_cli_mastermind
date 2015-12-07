=begin
  Create a method deep_dup which returns a completely new object on a 2-or-more dimensional array. Ruby's simple dup method will be useful but not the only thing you use.\

  Brainstorming
  how would you go through every item and see if something is an array and then go through all of those items as well.
  - First off you need to dup the actualy item itself and then everything below it. 
=end

class Array
  def deep_dup
    dup
    map do |object|
      if object.is_a?(Array)
        object.deep_dup
      else
        object
      end
    end
  end

end

deeper_arr = [
                [ 1, [ 2, 3 ] ],
                [ 4, 5, 6],
                [ [ 7, 8, [ 9, 10 ]], [11, 12] ],
            ]

puts deeper_arr.object_id
puts deeper_arr[2][1].object_id
arr2 = deeper_arr.deep_dup
print arr2
puts arr2.object_id
puts arr2[2][1].object_id
