require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current = TicTacToeNode.new(game.board, mark)
    not_losing_node = nil
    current.children.each do |child|
      not_losing_node = child if not_losing_node.nil? && !child.losing_node?(mark)
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    if not_losing_node.nil?
      raise "Should not ever lose"
    else
      not_losing_node.prev_move_pos
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
