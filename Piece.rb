#require_relative 'Board.rb'
require 'byebug'
class Piece
  attr_reader :color, :board
  attr_accessor :position

  def initialize(pos, color, board)
    # debugger
    @board = board
    @position = pos
    @color = color
  end

  def valid_moves
  #  raise NotYetImplementedError
  end

  def capture_moves
    valid_moves
  end

  def update_pos(new_pos)
    @position = new_pos
  end

  def dup(new_board)
    self.class.new(@position, @color, new_board)
  end

  def check_checks(arr)
    final_arr = []

    arr.each do |move|
      copy = self.board.dup
      copy.move_piece!(self.position, move)
      final_arr << move unless copy.in_check?(self.color)
    end

    final_arr
  end



end
