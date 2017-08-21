require_relative "binary_search_tree"

def kth_largest(tree_node, k)
  # in_order_traversal(tree_node)[k+1]
  back_traversal(tree_node)[k - 1]
end


def back_traversal(tree_node, arr = [])
  return arr if tree_node.nil?
  arr = back_traversal(tree_node.right, arr) if tree_node.right
  arr << tree_node
  arr = back_traversal(tree_node.left, arr) if tree_node.left
  arr
end

# def in_order_traversal(tree_node, arr = [])
#   return arr if tree_node.nil?
#   arr = in_order_traversal(tree_node.left, arr) if tree_node.left
#   arr << tree_node
#   arr = in_order_traversal(tree_node.right, arr) if tree_node.right
#   arr
# end
