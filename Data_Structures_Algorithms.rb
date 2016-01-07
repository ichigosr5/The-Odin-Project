class Node
  attr_accessor :value, :parent_node, :left_child_node, :right_child_node
  def initialize(value)
    @value = value
  end
end

def build_tree(array, rando = [array[0]])
  return nil if array.empty?
  $nodes ||= {}
  $first ||= 0
  $nodes[rando[0]] = Node.new(rando[0])
  $nodes[rando[0]].parent_node = rando[1] if $first == 1
  puts rando[0]
  parent = $nodes[rando[0]]
  $first = 1 if $first == 0
  array.delete(rando)
  left = array.select {|num| num < rando[0]}
  right = array.select {|num| num > rando[0]}
  $nodes[rando[0]].left_child_node = build_tree(left, [left[0], parent])
  $nodes[rando[0]].right_child_node = build_tree(right, [right[0], parent])
  return $nodes[rando[0]]
end

def breath_first_search(num)
  current_node = $nodes.values[0]
  queue = []
  first = true
  loop do
    queue << current_node.left_child_node unless current_node.left_child_node.nil?
    queue << current_node.right_child_node unless current_node.right_child_node.nil?
    queue.delete_at(0) if first == false
    (puts "Found no match"; break) if queue.empty?
    current_node = queue[0]
    return current_node.value if current_node.value == num
    first = false if first
  end
end

def depth_first_search(num)
  stack = []
  checked = []
  current_node = $nodes.values[0]
  loop do
    if (checked.none? {|node| node == current_node.left_child_node}) && (current_node.left_child_node != nil)

      if current_node != stack[-1]
        stack << current_node
        return current_node.value if current_node.value == num
        checked << current_node
      end

      (current_node = current_node.left_child_node; next)

    elsif (checked.none? {|node| node == current_node.right_child_node}) && (current_node.right_child_node != nil)

      if current_node != stack[-1]
        stack << current_node
        return current_node.value if current_node.value == num
        checked << current_node
      end

      (current_node = current_node.right_child_node; next)

    elsif (current_node.left_child_node.nil?) && (current_node.right_child_node.nil?)
      stack << current_node
      return current_node.value if current_node.value == num
      checked << current_node
    end

    stack.delete_at(-1)
    current_node = stack[-1]
    (puts "Found no match."; break) if stack.empty?
  end
end

def dfs_rec(num, node = $nodes.values[0])
  return nil if node.nil?
  return node.value if node.value == num
  left = dfs_rec(num, node.left_child_node)
  return left if left == num
  right = dfs_rec(num, node.right_child_node)
  return right if right == num
  puts "Found no match." if node == $nodes.values[0]
end

build_tree([4,2,3,1,5,8,6,12])
dfs_rec(6)
