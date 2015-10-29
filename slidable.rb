require 'byebug'
module Slidable
  def valid_moves
    start = self.position
    arr = []
    if self.is_a?(Bishop) || self.is_a?(Queen)
        arr += (explore_dir(start, 1, 1) +
        explore_dir(start, 1, -1) +
        explore_dir(start, -1, -1) +
        explore_dir(start, -1, 1))
    end

    if self.is_a?(Rook) || self.is_a?(Queen)
      arr += (explore_dir(start,1,0)+explore_dir(start,0,1)+explore_dir(start,-1,0)+explore_dir(start,0,-1))
    end
    arr
    #check_checks(arr)
  end

  def explore_dir (start, dx, dy)
    # debugger
    valid_pos = []
    explored_pos = [start[0] + dx, start[1] + dy]
    x, y = explored_pos

    while explored_pos.all? {|el| el.between?(0,7) } && self.board.grid[x][y].is_a?(EmptyPiece)
       valid_pos << explored_pos
       x += dx
       y += dy
       explored_pos = [x,y]
    end
    if explored_pos.all? {|el| el.between?(0,7) } && self.board.grid[x][y].color != self.color
      valid_pos << explored_pos
    end
    valid_pos
  end

end
