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

  def find(value, node = root)
    return nil if node.nil?
    return node if value == node.data

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

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
    elsif value > node.data
      node.right = delete(value, node.right)
    elsif node.left.nil?
      return node.right
    elsif node.right.nil?
      return node.left
    else
      min_value = node.right
      min_value = min_value.left until min_value.left.nil?
      node.data = min_value.data
      node.right = delete(min_value.data, node.right)
    end
    node
  end

  def level_order_recursive(node = root, discovered_nodes = [], nodes = [], start: true, &block)
    return nil if node.nil?

    discovered_nodes << node.left unless node.left.nil?
    discovered_nodes << node.right unless node.right.nil?

    if block_given?
      yield(node)
      level_order_recursive(discovered_nodes.shift, discovered_nodes, nodes, start: false, &block)
    else
      nodes << node.data
      level_order_recursive(discovered_nodes.shift, discovered_nodes, nodes, start: false)
    end

    p nodes if start && !nodes.empty?
  end

  def level_order_iterative(node = root, &block)
    return [] if node.nil?

    nodes = [node]
    discovered_nodes = [node]

    until discovered_nodes.empty?
      current_node = discovered_nodes.shift
      nodes << current_node.left  unless current_node.left.nil?
      nodes << current_node.right unless current_node.right.nil?
      discovered_nodes << current_node.left  unless current_node.left.nil?
      discovered_nodes << current_node.right unless current_node.right.nil?
    end

    return nil if nodes.nil?

    if block_given?
      nodes.each(&block)
    else
      node_array = []
      nodes.each {|el| node_array << el.data}
      p node_array
    end
  end

  # left, root, right
  def inorder(node = root, nodes = [], start: true, &block)
    return nil if node.nil?

    inorder(node.left, nodes, start: false, &block)
    if block_given?
      yield(node)
    else
      nodes << node.data
    end
    inorder(node.right, nodes, start: false, &block)

    p nodes if start && !nodes.empty?
  end

  # root, left, right
  def preorder(node = root, nodes = [], start: true, &block); end

  # left, right, root
  def postorder(node = root, nodes = [], start: true, &block); end

  def print_preorder_BST(root)
    return if root.nil?

    print "#{root.data} "
    print_preorder_BST(root.left)
    print_preorder_BST(root.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = [1, 2, 5, 7, 9, 5, 3]
tree = Tree.new(test)
tree.print_preorder_BST(tree.root)
print "\n"
tree.pretty_print(tree.root)
print "\n"
# tree.insert(7)
tree.print_preorder_BST(tree.root)
print "\n"
tree.pretty_print(tree.root)
print "\n"

tree.pretty_print(tree.root)
1 + 1
