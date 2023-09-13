class Node
  include Comparable
  attr_accessor :list, :left, :right

  def initialize (list = nil, left = nil, right = nil)
    @list = list
    @left = left
    @right = right
  end
end

class Tree
  require 'thread'
attr_accessor :root

  def initialize(values)
    @values = values
    @root = nil
  end

  def build_tree(values)
    return nil if values.empty?

    count = values.size
    mid = count / 2
    root = Node.new(values[mid])
    queue = Queue.new
    queue.push([root, [0, mid - 1]])
    queue.push([root, [mid + 1, count - 1]])

    while !queue.empty?
      current = queue.pop
      parent = current[0]
      left = current[1][0]
      right = current[1][1]

      if left <= right && !parent.nil?
        mid = (left + right) / 2
        child = Node.new(values[mid])

        if values[mid] < parent.list
          parent.left = child
        else
          parent.right = child
        end

        queue.push([child, [left, mid - 1]])
        queue.push([child, [mid + 1, right]])
      end
    end

    return root
  end

  def printBST(root)
    return if root.nil?

    print "#{root.list} "
    printBST(root.left)
    printBST(root.right)
  end

end



test = [1,2,,3,4,8]
tree = Tree.new(test)
tree3 = tree.build_tree(test)
tree.printBST(tree3)

