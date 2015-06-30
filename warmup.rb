#deep dup only 2D array

class Array

  def deep_dup
    self.map do |item|
      if item.class == Array
        item.map do |deep_item|
          deep_item
        end
      else
        item
      end
    end
  end

end



# arr = [ [1,2, ['q']], [3,4,['a']]]
# duper = arr.deep_dup
# p duper.object_id
# p arr.object_id
# puts
# print duper
# p duper[0].object_id
# p duper[3].object_id
# puts
# print arr
# p arr[0].object_id
# p arr[3].object_id