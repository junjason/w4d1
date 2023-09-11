require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    start_node = TicTacToeNode.new(game.board, mark)
    start_node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    next_move_node = nil
    start_node.children.each do |child|
      if !child.losing_node?(mark)
        next_move_node = child
      end
    end

    if next_move_node == nil
      raise RuntimeError.new("No non-losing nodes")
    end

    next_move_node.prev_move_pos
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end