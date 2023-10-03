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
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    else
      node.right = delete(value, node.right)
    end

    if node.left.nil?
      node.right
    elsif node.right.nil?
      node.left
    else
      succ_parent = node
      succ = node.right
      until succ.left.nil?
        succ_parent = succ
        succ = succ.left
      end
      if succ_parent != node
        succ_parent.left = succ.right
      else
        succ_parent.right = succ.right
      end
      node.data = succ.data
      succ = nil
      node
    end
  end

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

test = [1, 2, 4, 5, 3, 9,6]
tree = Tree.new(test)
tree.print_inorder_BST(tree.root)
print "\n"
tree.pretty_print(tree.root)
print "\n"
tree.insert(7)
tree.print_inorder_BST(tree.root)
print "\n"
tree.pretty_print(tree.root)
1 + 1
