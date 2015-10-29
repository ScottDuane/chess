module Steppable

  def valid_moves
    arr = @possible_moves.map do |el|
      x, y = el
      [@position[0] + x, @position[1] + y ]
    end
    # puts "Current valid moves are #{arr}"
    final_arr = arr.select do |el|
      el.all? { |cor| cor.between?(0,7) } && self.board.grid[el[0]][el[1]].color != self.color
    end
    final_arr
  #  check_checks(arr)
  end

end
