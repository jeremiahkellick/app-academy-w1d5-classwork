require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    game.board
    current = TicTacToeNode.new(game.board.dup, mark)
    return current.children.max_by do |child|
      score = child.score(mark)
      puts "pos: #{child.prev_move_pos} score: #{score}"
      score
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
