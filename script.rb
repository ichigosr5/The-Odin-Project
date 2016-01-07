module Enumerable
  def hash_to_array
    key_array = self.keys
    value_array = self.values
    hash_array = []

    0.upto(key_array.length - 1) do |num|
      sub_array = [key_array[num], value_array[num]]
      hash_array << sub_array
    end
    array = hash_array
  end
  def my_each
    array = self
      if self.class == Hash
          self.hash_to_array
      end

      0.upto(array.length - 1) do |num|
        yield(array[num])
      end
  end

  def my_each_with_index
    array = self
      if self.class == Hash
          self.hash_to_array
      end
      0.upto(array.length - 1) do |num|
        array[num] = [array[num], num]
        yield(array[num])
      end
  end

  def my_select
    new_object = []
    self.my_each do |object|
      if yield(object)
        new_object << object
      end
    end
    return new_object
  end

  def my_all?
    all = true
    self.my_each do |object|
      if yield(object) == false
        all = false
        break
      end
    end
    return all
  end

  def my_any?
    any = false
    self.my_each do |object|
      if yield(object)
        any = true
        break
      end
      return any
    end
  end

  def my_none?
    none = false
    self.my_each do |object|
      if yield(object) == true
        none = true
        break
      end
    end
    return none
  end

  def my_count
    count = 0
    if block_given?
      self.my_each do |object|
        if yield(object)
          count += 1
        end
      end

    else count = self.length
    end
    return count
  end

  def my_map(&proc)
    new_object = []
    self.my_each do |object|
      new_object << proc.call(object)
    end
    if proc.nil? != true
      newer_object = []
      new_object.my_each {|object| newer_object << yield(object)}
      puts newer_object
    end
    puts new_object if newer_object.nil?
  end

  def my_inject(result = nil)
    if result.nil?
      array = self
      array = self.hash_to_array if self.class == Hash
      result = array[0]
      1.upto(array.length - 1) do |num|
        result = yield(result, array[num])
      end
      return result
    else
      self.my_each do |object|
        result = yield(result, object)
      end
      return result
    end
  end
end
testa = Proc.new {|num| num * 2}
array = [1,2,3]
array.my_map(&testa)
