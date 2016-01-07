def fibonacci(num)
  $array ||= []
  if num == 1
    $array << 0
    $array << 1
    return $array
  end
  fibonacci(num - 1)
  $array << ($array[num - 2] + $array[num - 1])
end
