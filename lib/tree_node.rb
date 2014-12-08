class PolyTreeNode

  def initialize(value)
    @value = value
    @current_parent = nil
    @children = Array.new
  end

  def parent
    @current_parent
  end

  def parent=(new_parent)
    unless @current_parent == new_parent
      @current_parent.children.delete(self) unless @current_parent.nil?
      @current_parent = new_parent
      unless @current_parent.nil?
        @current_parent.children << self
      end
    end
  end

  def children
    @children
  end

  def add_child(child)
    @children << child unless @children.include?(child)
    child.parent = self
  end

  def remove_child(child)
    if @children.delete(child).nil?
      raise StandardError, 'Not A Child!!!'
    end
    @children.delete(child)
    child.parent = nil
  end

  def value
    @value
  end

  def dfs(target_value)
    return self if target_value == @value

    @children.each do |child|
      maybe_target = child.dfs(target_value)
      return maybe_target unless maybe_target.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      maybe_target = queue.shift
      if maybe_target.value == target_value
        return maybe_target
      else
        maybe_target.children.each { |child| queue << child }
      end
    end

    nil
  end

  def trace_path_back
    path = [self.value]
    if self.parent.nil?
      return path
    end

    self.parent.trace_path_back + path
  end

  def inspect
    "Node: #{value}\nChildren: #{children}\n\n\n"
  end
end



class KnightPathFinder
  attr_reader :starting_node

  def initialize(starting_pos = [0, 0])
    @starting_node = PolyTreeNode.new(starting_pos)
    @visited_positions = [@starting_node.value]
  end

  def find_path(dest_pos)
  end

  def self.valid_moves(position)
    x, y = position[0], position[1]
    ending_positions = []
    possible_moves = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    possible_moves.each do |move|
      ending_positions << [x + move[0], y + move[1]]
    end

    ending_positions.select do |pos|
      pos[0].between?(0, 7) && pos[1].between?(0, 7)
    end
  end

  def new_move_positions(position)
    possible_moves = self.class.valid_moves(position).select do |pos|
      !@visited_positions.include?(pos)
    end

    @visited_positions += possible_moves
    possible_moves
  end

  def build_move_tree
    queue = [@starting_node]

    until queue.empty?
      node = queue.shift
      new_move_positions(node.value).each do |pos|
        child_node = PolyTreeNode.new(pos)
        node.add_child(child_node)
      end
      queue += node.children
    end
  end

  def find_path(end_pos)
    @starting_node.dfs(end_pos).trace_path_back
  end

end

k = KnightPathFinder.new
k.build_move_tree