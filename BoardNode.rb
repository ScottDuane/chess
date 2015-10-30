# require 'computerplayer.rb'
class BoardNode
  attr_accessor :board, :maximizing, :value, :color, :previous, :children
  def initialize(board, maximizing, color, previous = nil)
    @board = board
    @maximizing = maximizing
    @value = nil
    @color = color
    @children = []
    @previous = previous
  end

  def evaluate_node
    self.value = self.board.sum(self.color)
  end

  def make_children
    self.children = []
    self.board.all_pieces_of_color(color).each do |piece|
      # debugger 
      piece.valid_moves.each do |move|
        copy_board = self.board.dup
        # debugger
        copy_board.make_move(piece.position, move, self.color)
        self.color == :white ? opp_color = :black : opp_color = :white
        child = BoardNode.new(copy_board, !self.maximizing, opp_color, [piece.position, move])
        self.children << child
      end
    end
  end

  def find_move(result)
    self.children.each do |child|
      if child.value == result
        return child
      end
    end

  end
end
