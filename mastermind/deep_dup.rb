module DeepDup
  def deep_dup
    new_array = []
    # while array.is_a? Array
    self.each_with_index do |item, index|
      if item.is_a? Array
        new_array[index] = item.deep_dup
      else
        new_array[index] = item
      end
    end
    # end
    new_array
  end
end

class Array
  include DeepDup
end