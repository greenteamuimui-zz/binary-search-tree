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
    count = 0
    return count if tree_node.right.nil? && tree_node.left.nil?
    count += 2 if tree_node.right
    count += 2 if tree_node.left
  end

  def is_balanced?(tree_node = @root)
    return true if left.nil? && right.nil?
    return false if (left - right).abs != 0 || (left - right).abs != 1
    left = depth(@root.left)
    right = depth(@root.right)
    is_balanced?(@root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
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