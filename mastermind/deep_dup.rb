module DeepDup
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

class Array
  include DeepDup
end