require_relative 'Piece.rb'

class Pawn < Piece
  def display
    if @color == :white
      "\u2659"
    else
      "\u265F"
    end
  end

  attr_accessor :moved

  def initialize(pos, color, board)
    super
    @moved = false
  end

  def valid_moves
    @color == :white ? dx = -1 : dx = 1
    @color == :white ? other_color = :black : other_color = :white

    moves = []
    x, y = @position
    moves << [x + dx, y ] if (x+dx).between?(0,7) && @board.grid[x+dx][y].is_a?(EmptyPiece)
    moves << [x + dx*2, y ] if (x+dx*2).between?(0,7) && @board.grid[x + dx*2][y].is_a?(EmptyPiece) && !@moved
    moves << [x + dx, y + 1] if (x+dx).between?(0,7) && (y+1).between?(0,7) && @board.grid[x+dx][y+1].color == other_color
    moves << [x + dx, y - 1] if (x+dx).between?(0,7) && (y-1).between?(0,7) && @board.grid[x+dx][y-1].color == other_color
  #  check_checks(moves)
    moves
  end

  def capture_moves
    @color == :white ? dx = -1 : dx = 1
    @color == :white ? other_color = :black : other_color = :white

    moves = []
    x, y = @position
    moves << [x + dx, y + 1] if @board.grid[x+dx][y+1].color == other_color
    moves << [x + dx, y - 1] if @board.grid[x+dx][y-1].color == other_color
    check_checks(moves)
  end

  def dup(new_board)
    new_pawn = self.class.new(@position, @color, new_board)
    new_pawn.moved = self.moved
    new_pawn
  end


end
