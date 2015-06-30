class Array

  def initialize

  end

  def deep_dup

    new_arr = []

    self.each_with_index do |subarray, index|

      new_arr[index]=[]

      subarray.each_with_index do |item, index2|

        new_arr[index][index2] = item.dup

      end

    end

    new_arr

  end

end