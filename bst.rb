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

    middle = values.size / 2

    root = Node.new(values[middle])

    root.left = build_tree(values[0...middle])
    root.right = build_tree(values[(middle + 1)..])

    root
  end

  def find(value); end

  def insert(value, node = root)
    if node.nil?
      Node.new(value)
    elsif value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
  end

  def delete(value); end

  def print_inorder_BST(root)
    return if root.nil?

    print "#{root.data} "
    print_inorder_BST(root.left)
    print_inorder_BST(root.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = [1, 2]
tree = Tree.new(test)
tree.print_inorder_BST(tree.root)
print "\n"
tree.pretty_print(tree.root)
print "\n"
tree.insert(9)
tree.pretty_print(tree.root)
1 + 1
