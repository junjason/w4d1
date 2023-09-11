require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator || @board.winner == nil
        return false
      else
        return true
      end
    end

    (self.children.all? {|child| child.losing_node?(evaluator)} && next_mover_mark == evaluator) || 
    (self.children.any? {|child| child.losing_node?(evaluator)} && next_mover_mark != evaluator)
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end

    (self.children.any? {|child| child.winning_node?(evaluator)} && next_mover_mark == evaluator)||
    (self.children.all? {|child| child.winning_node?(evaluator)} && next_mover_mark != evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_children = []
    (0...@board.rows.length).each do |row|
      (0...@board.rows[row].length).each do |col|
        pos = [row, col]
        if @board.empty?(pos)
          new_mark = nil
          if next_mover_mark == :o
            new_mark = :x
          else
            new_mark = :o
          end
          new_node = TicTacToeNode.new(@board.dup, new_mark, pos)
          new_node.board[pos] = next_mover_mark
          all_children << new_node
        end
      end
    end
    all_children

  end
end
