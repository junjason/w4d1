class PolyTreeNode
    attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    old_parent = self.parent 
    if old_parent
        old_parent.children.delete(self)
    end
    
    @parent = parent_node
    
    if parent_node && !parent_node.children.include?(self)
        parent_node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise RuntimeError.new("node is not a child") if !child_node.parent
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
        result = child.dfs(target_value)
        return result if result 
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    while !queue.empty?
        next_el = queue.shift
        return next_el if next_el.value == target_value
        next_el.children.each {|child| queue << child }
    end
    nil
  end
end