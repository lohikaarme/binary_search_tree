# frozen_string_literal: true

# Node class for creating nodes within a binary tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  # Initialize node with given data
  # Optionally, set left and right child nodes
  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# Tree class for creating binary search tre
# Methods to build tree, find/insert/delete a node, traverse tree in different orders
class Tree
  attr_accessor :root, :data

  def initialize(values)
    @data = values.sort.uniq
    @root = build_tree(data)
  end

  # Method to build binary search tree from given values
  def build_tree(values)
    return nil if values.empty?

    middle = values.size / 2

    root = Node.new(values[middle])

    root.left = build_tree(values[0...middle])
    root.right = build_tree(values[(middle + 1)..])

    root
  end

  # Method to find a node with the given value in the tree
  # @param value [Object] The value to search for
  # @param node [Node] The current node in the tree
  # @return [Node, nil] The node with the given value if it exists, or nil if it doesn't
  def find(value, node = root)
    return nil if node.nil?
    return node if value == node.data

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  # Method to insert a new value into the tree
  # @param value [Object] The value to insert
  # @param node [Node] The current node in the tree
  # @return [nil] nil if root doesn't exist
  def insert(value, node = root)
    return nil if value == node.data

    if value < node.datax
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # Method to delete a node with the given value from the tree
  # @param value [Object] The value to delete
  # @param node [Node] The current node in the tree
  # @return [Node, nil] The deleted node, or nil if root doesn't exist
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

  # Method to perform level order of the tree recursively
  # Accepts a block which is executed for each node
  # Returns array of node data if no block is present
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

  # Method to perform level order of the tree iteratively
  # Accepts a block which is executed for each node
  # Returns array of node data if no block is present
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
      nodes.each { |el| node_array << el.data }
      p node_array
    end
  end

  # Method to perform inorder traversal of the tree
  # Accepts a block which is executed for each node
  # Returns array of node data if no block is present
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

  # Method to perform preorder traversal of the tree
  # Accepts a block which is executed for each node
  # Returns array of node data if no block is present
  def preorder(node = root, nodes = [], start: true, &block)
    return nil if node.nil?

    if block_given?
      yield(node)
    else
      nodes << node.data
    end
    preorder(node.left, nodes, start: false, &block)
    preorder(node.right, nodes, start: false, &block)

    p nodes if start && !nodes.empty?
  end

  # Method to perform postorder traversal of the tree
  # Accepts a block which is executed for each node
  # Returns array of node data if no block is present
  def postorder(node = root, nodes = [], start: true, &block)
    return nil if node.nil?

    postorder(node.left, nodes, start: false, &block)
    postorder(node.right, nodes, start: false, &block)
    if block_given?
      yield(node)
    else
      nodes << node.data
    end

    p nodes if start && !nodes.empty?
  end

  # Method to determine height of node from longest path to a leaf in tree
  # @param node [Node, Comparable] The node (or value of the node) in the tree to measure height of
  # @return [Integer] Height of node, 0 if empty or node doesn't exist
  def height(node = root, start: true)
    node = find(node) if start && node.is_a?(Comparable)
    return 0 if node.nil?

    left_height = height(node.left, start: false)
    right_height = height(node.right, start: false)

    [left_height, right_height].max + 1
  end

  # Method to find the depth of a node with the given value in the tree
  # @param value [Object] The value to search for
  # @param node [Node] The current node in the tree
  # @return [Integer, nil] Depth of node, or nil if node doesn't exist
  def depth(value, node = root)
    return nil if node.nil?

    if value < node.data
      depth(value, node.left) + 1
    elsif value > node.data
      depth(value, node.right) + 1
    else
      1
    end
  end

  # Method to determine if tree is balanced
  # @return [Boolean] True if a balanced tree, False if not
  def balanced?(node = root)
    left = 0
    right = 0
    left = height(node.left.data) unless node.left.nil?
    right = height(node.right.data) unless node.right.nil?
    (left - right).abs <= 1
  end

  # Method to rebalance a tree if it is unbalanced
  # @returns [Tree, nil] rebalanced tree, or nil if no tree exists
  def rebalance
    return nil if root.nil?

    self.data = inorder
    self.root = build_tree(data)
    self
  end

  # prints tree in preorder traversal
  def print_preorder_BST(root)
    return if root.nil?

    print "#{root.data} "
    print_preorder_BST(root.left)
    print_preorder_BST(root.right)
  end

  # Method to print tree in visual format
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
p tree.height(2)
p tree.depth(2)
p tree.balanced?
p tree.rebalance
p tree.delete(7)
p tree.delete(9)
p tree.rebalance
tree.pretty_print(tree.root)
1 + 1
