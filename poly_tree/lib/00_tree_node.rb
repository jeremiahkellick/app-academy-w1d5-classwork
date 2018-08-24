class PolyTreeNode

  attr_reader :parent, :children, :value
    
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(other_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = other_node
    other_node.children << self unless other_node.nil? || other_node.children.include?(self)
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise ArgumentError, "Not a child" unless self.children.include?(child_node)
    child_node.parent = nil
  end
  
  def dfs(target)
    return self if self.value == target
    
    children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?      
    end
    
    nil
  end
  
  def inspect
    self.value
  end

  def bfs(target)
    queue = [self]
    
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue.concat(current.children)
    end
    
    nil
  end
  
end