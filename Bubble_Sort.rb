def bubble_sort(array)
  1.upto(array.length - 1) do |round|
    swap, rep, = false, 1
    array.each do |num|
      index = array.index(num)
      if num > array[index + 1]
        array[index], array[index + 1] = array[index + 1], array[index]
        swap = true if swap == false
      end
      break if rep == array.length - round
      rep += 1
    end
    break if swap == false
  end
  return array
end

def bubble_sort_by(array)
  1.upto(array.length - 1) do |round|
    swap, rep, = false, 1
    array.each do |string|
      index = array.index(string)
      if yield(array[index], array[index + 1]) > 0
        array[index], array[index + 1] = array[index + 1], array[index]
        swap = true if swap == false
      end
      break if rep == array.length - round
      rep += 1
    end
    break if swap == false
  end
  return array
end
