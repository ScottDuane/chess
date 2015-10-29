class Player
  attr_reader :color, :other_color

  def initialize(color, game)
    @color = color
    color == :white ? @other_color = :black : @other_color = :white 
    @game = game
  end

  def get_move
  end

  def piece_at?(pos)
    @game.board.grid[pos[0]][pos[1]].color == self.color
  end

end
