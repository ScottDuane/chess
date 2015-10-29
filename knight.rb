require_relative 'Piece.rb'
require_relative 'steppable.rb'

class Knight < Piece
include Steppable
def initialize(pos, color, board)
  super
  @possible_moves = [
    [-2,-1],
    [-1,-2],
    [-2,1],
    [-1,2],
    [1,-2],
    [2,-1],
    [1,2],
    [2,1]
  ]
end

  def display
    if @color == :white
      "\u2658"
    else
      "\u265E"
    end
  end



end
