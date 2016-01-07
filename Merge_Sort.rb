def merge_sort(array)
  if array.length >= 2
      first_half = array.slice(0, array.length/2)
      second_half = array.slice((array.length * 0.5), (array.length - array.length/2))
      first_sort = merge_sort(first_half)
      second_sort = merge_sort(second_half)
  end

  if second_sort
     array = []
     while first_sort[0] && second_sort[0] do

         if first_sort[0] > second_sort[0]
           array << second_sort[0]
           second_sort.delete_at(0)
         elsif second_sort[0] > first_sort[0]
           array << first_sort[0]
           first_sort.delete_at(0)
         else
           array << first_sort[0]
           array << second_sort[0]
           first_sort.delete_at(0)
           second_sort.delete_at(0)
         end
     end

     if first_sort[0].nil?
       second_sort.each do |element|
         array << element
         second_sort -= [second_sort[0]]
       end

     elsif second_sort[0].nil?
       first_sort.each do |element|
         array << element
         first_sort -= [first_sort[0]]
       end
     end
  end
  return array
end
