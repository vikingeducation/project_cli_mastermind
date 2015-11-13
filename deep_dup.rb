class Array
  def deep_dup
    new_array = []
    self.each_with_index do |item, index|
      if item.is_a? Array
        new_array[index] = item.deep_dup
      else
        new_array[index] = item
      end
    end
    new_array
  end
end

# arr = [1, 2, 3, 4]
# arr = [ [1, 2], [3, 4] ]
arr = [
        [ 1, [ 2, 3 ] ],
        [ 4, 5, 6],
        [ [ 7, 8, [ 9, 10 ]], [11, 12] ],
      ]

puts "arr = #{arr}"
# Verify their object_ids
puts "arr.object_id = #{arr.object_id}"
#=> 70349854069800
puts "arr[0].object_id = #{arr[0].object_id}"
#=> 70349854069960
puts "arr[1].object_id = #{arr[1].object_id}"
#=> 70349854069840

duper = arr.deep_dup

puts "duper = #{duper}"
# Verify they are different ids
puts "duper.object_id = #{duper.object_id}"
#=> 70349854047610
puts "duper[0].object_id = #{duper[0].object_id}"
#=> 70349854041100
puts "duper[1].object_id = #{duper[1].object_id}"
#=> 70342030583020
