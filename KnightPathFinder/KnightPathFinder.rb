require_relative '../poly_tree/lib/00_tree_node.rb'
require 'set'

class KnightPathFinder
  
  DELTAS = [
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1]
  ]
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = Set.new([start_pos])
  end
  
  def self.valid_moves(pos)
    DELTAS.map {|delta| add_pos(pos, delta)}.select do |move|
      move.all? { |coord| coord.between?(0,7) }
    end
  end
  
  def self.add_pos(pos1, pos2) 
    [pos1.first + pos2.first, pos1.last + pos2.last]
  end
  
  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject { |move| @visited_positions.include?(move) }
    @visited_positions.merge(new_moves)
    new_moves
  end
  
  def build_move_tree
    @root_node = PolyTreeNode.new(@start_pos)
    queue = [@root_node]
    until queue.empty?
      current = queue.shift
      new_move_positions(current.value).each do |new_pos|
        node = PolyTreeNode.new(new_pos)
        node.parent = current
        queue << node
      end
    end
  end
  
  def find_path(end_pos)
    trace_path_back(@root_node.bfs(end_pos))
  end
  
  def trace_path_back(node)
    return [] if node.nil?
    trace_path_back(node.parent) + [node.value]
  end
  
end
