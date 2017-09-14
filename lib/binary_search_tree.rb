# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"
require 'byebug'

class BinarySearchTree
  attr_accessor :root, :left, :right

  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
      return
    end
    recursion(@root, value)
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    if value > tree_node.value
      return nil if tree_node.right.nil?
      find(value, tree_node.right)
    else
      return nil if tree_node.left.nil?
      find(value, tree_node.left)
    end
  end

  def delete(value)
    # debugger
    node = self.find(value, @root)
    if node.parent.nil?
      @root = nil
      return
    end
    if node.right.nil? && node.left.nil?
      if node.parent.value < node.value
        node.parent.right = nil
      else
        node.parent.left = nil
      end
    elsif node.right.nil? || node.left.nil?
      if node.parent.value < node.value
        node.parent.right = node.right.nil? ? node.left : node.right
      else
        node.parent.left = node.right.nil? ? node.left : node.right
      end
    else
      if node.parent.value < node.value
        node.parent.right = maximum(node.left)
      else
        node.parent.left = maximum(node.left)
      end
      if maximum(node.left).left
        maximum(node.left).parent.right = maximum(node.left).left
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    # debugger
    return -1 if tree_node.nil?
    # return count if tree_node.right.nil? && tree_node.left.nil?
    if depth(tree_node.right) > depth(tree_node.left)
      count = depth(tree_node.right) + 1
    else
      count = depth(tree_node.left) + 1
    end
    count
  end

  def is_balanced?(tree_node = @root)
    # debugger
    return true if tree_node.left.nil? || tree_node.right.nil?
    return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
    is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
    # return [] if tree_node.nil?
    # arr = in_order_traversal(tree_node.left, arr) if tree_node.left
    # arr << tree_node.value
    # arr = in_order_traversal(tree_node.right, arr) if tree_node.right
    # arr
  end

  def count_leafs(node = @root, count = 0)
    # debugger
    return count if node.nil?
    count += 1 if node.left.nil? && node.right.nil?
    count_leafs(node.left, count)
    count_leafs(node.right, count)
    count
  end

  def pre_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    arr.push(tree_node.value)
    pre_order_traversal(tree_node.left, arr)
    pre_order_traversal(tree_node.right, arr)
    arr
  end

  def post_order_traversal(tree_node = @root, arr = [])
  return arr if tree_node.nil?
  return arr.push(tree_node.value) if tree_node.left.nil? && tree_node.right.nil?
  post_order_traversal(tree_node.left, arr)
  post_order_traversal(tree_node.right, arr)
  arr.push(tree_node.value)
  # p arr
end


  private
  # optional helper methods go here:

  def recursion(root, value)
    if root.value < value
      if root.right.nil?
        root.right = BSTNode.new(value)
        root.right.parent = root
      else
        recursion(root.right, value)
      end
    else
      if root.left.nil?
        root.left = BSTNode.new(value)
        root.left.parent = root
      else
        recursion(root.left, value)
      end
    end
  end


end

bst = BinarySearchTree.new
[5, 3, 7, 2, 4, 1, 10, 9, 11].each do |el|
  bst.insert(el)
end
p bst.root
p bst.count_leafs
p bst.pre_order_traversal
p bst.post_order_traversal
