class EmptyPiece

  attr_reader :color, :position
  def initialize(pos, board)
    @position = pos
    @board = board
    @color = :null
  end

  def display
    " "
  end

  def dup(new_board)
    EmptyPiece.new(@position, new_board)
  end

  def valid_moves
    []
  end
end
