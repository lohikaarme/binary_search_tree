# frozen_string_literal: true

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root

  def initialize(values)
    @values = values.sort
    @root = nil
  end

  def build_tree(values)
    return nil if values.empty?

    values = values.sort

    count = values.size
    mid = count / 2
    root = Node.new(values[mid])
    queue = Queue.new
    queue.push([root, [0, mid - 1]])
    queue.push([root, [mid + 1, count - 1]])

    until queue.empty?
      current = queue.pop
      parent = current[0]
      left = current[1][0]
      right = current[1][1]

      next unless left <= right && !parent.nil?

      mid = (left + right) / 2
      child = Node.new(values[mid])

      if values[mid] < parent.data
        parent.left = child
      else
        parent.right = child
      end

      queue.push([child, [left, mid - 1]])
      queue.push([child, [mid + 1, right]])
    end

    root
  end

  def printBST(root)
    return if root.nil?

    print "#{root.data} "
    printBST(root.left)
    printBST(root.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value); end

  def insert(value); end

  def delete(value); end
end

test = [1, 2, 7, 3, 4, 8]
tree = Tree.new(test)
tree3 = tree.build_tree(test)
tree.printBST(tree3)
print "\n"
tree.pretty_print(tree3)
1 + 1
