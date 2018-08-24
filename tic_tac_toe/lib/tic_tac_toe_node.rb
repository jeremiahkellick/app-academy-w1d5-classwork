require_relative 'tic_tac_toe'

class TicTacToeNode
  
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(player_mark)
    return @board.winner != player_mark && @board.winner != nil if @board.over?
    if next_mover_mark == player_mark
      children.all? { |child| child.losing_node?(player_mark) }
    else
      children.any? { |child| child.losing_node?(player_mark) }
    end
  end

  def winning_node?(player_mark)
    return @board.winner == player_mark if @board.over?
    if next_mover_mark == player_mark
      children.any? { |child| child.winning_node?(player_mark) }
    else
      children.all? { |child| child.winning_node?(player_mark) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    
    arr = []
    
    [0, 1, 2].product([0, 1, 2]).each do |pos|
      if @board.empty?(pos)
        new_board = @board.dup
        new_board[pos] = @next_mover_mark
        
        next_mark = @next_mover_mark == :x ? :o : :x
        
        arr << TicTacToeNode.new(new_board, next_mark, pos)
      end
    end
    
    arr
    
  end
end
