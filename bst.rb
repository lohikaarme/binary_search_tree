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
  attr_accessor :root, :data

  def initialize(values)
    @data = values.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(values)
    return nil if values.empty?
    middle = (values.size) / 2

    root = Node.new(values[middle])

    root.left = build_tree(values[0...middle])
    root.right = build_tree(values[(middle + 1)..-1])

    return root

  end

  def find(value); end

  def insert(value); end

  def delete(value); end

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

end

test = [1, 2, 7, 3, 4, 5, 6]
tree = Tree.new(test)
tree3 = tree.build_tree(test)
tree.printBST(tree3)
print "\n"
tree.pretty_print(tree3)
