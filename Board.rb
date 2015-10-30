require_relative 'pieces.rb'
require_relative 'empty_piece.rb'
require 'byebug'
class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @white_captures = []
    @black_captures = []
    populate_board
  end

  attr_reader :grid, :white_captures, :black_captures

  def populate_board
    #row 0
    # debugger
    @grid.each_with_index do |row, idx|
      row.each_with_index do |el, idy|
        @grid[idx][idy] = EmptyPiece.new([idx, idy], self)
      end
    end

    @grid[0][0] = Rook.new([0,0], :black, self)
    @grid[0][1] = Knight.new([0,1], :black, self)
    @grid[0][2] = Bishop.new([0,2], :black, self)
    @grid[0][3] = Queen.new([0,3], :black, self)
    @grid[0][4] = King.new([0,4], :black, self)
    @grid[0][5] = Bishop.new([0,5], :black, self)
    @grid[0][6] = Knight.new([0,6], :black, self)
    @grid[0][7] = Rook.new([0,7], :black, self)

    (0..7).each do |i|
      @grid[1][i] = Pawn.new([1,i], :black, self)
    end

    @grid[7][0] = Rook.new([7,0], :white, self)
    @grid[7][1] = Knight.new([7,1], :white, self)
    @grid[7][2] = Bishop.new([7,2], :white, self)
    @grid[7][3] = Queen.new([7,3], :white, self)
    @grid[7][4] = King.new([7,4], :white, self)
    @grid[7][5] = Bishop.new([7,5], :white, self)
    @grid[7][6] = Knight.new([7,6], :white, self)
    @grid[7][7] = Rook.new([7,7], :white, self)

    (0..7).each do |i|
      @grid[6][i] = Pawn.new([6,i], :white, self)
    end
  end

  def in_bounds?(pos)
    pos.all? {|x| x>=0 && x<8}
  end

  def make_move(start, finish, move_color)
    piece = @grid[start[0]][start[1]]
    return false unless piece.color == move_color
    return false if !piece.valid_moves.include?(finish)
    copy = self.dup
    copy.move_piece!(start, finish)
    if copy.in_check?(move_color)
      return false
    else
      self.move_piece(start, finish)
      return true
    end
  end

  def move_piece(start, finish)
    piece = @grid[start[0]][start[1]]
    raise Exception if piece.is_a?(EmptyPiece)
    raise Exception unless piece.valid_moves.include?(finish)
    add_to_captures(@grid[finish[0]][finish[1]])

    piece.update_pos(finish)
    @grid[start[0]][start[1]] = EmptyPiece.new(self, start)
    @grid[finish[0]][finish[1]] = piece
  end

  def move_piece!(start, finish)
    piece = @grid[start[0]][start[1]]
    raise Exception if piece.is_a?(EmptyPiece)
    piece.update_pos(finish)
    @grid[start[0]][start[1]] = EmptyPiece.new(self, start)
    @grid[finish[0]][finish[1]] = piece
  end

  def add_to_captures(captured_piece)
    if captured_piece.color == :white
      @white_captures << captured_piece
    elsif captured_piece.color == :black
      @black_captures << captured_piece
    end
  end

  def dup
    copy = Board.new
    @grid.each_with_index do |row, idx|
      row.each_with_index do |el , idy|
        copy.grid[idx][idy] = el.dup(copy)
      end
    end
    copy
  end

  def sum(color)
    sum = 0

    @grid.each do |row|
      row.each do |cell|
        if cell.color == color
          if cell.is_a?(Pawn)
            sum += 1
          elsif cell.is_a?(Bishop) || cell.is_a?(Knight)
            sum += 3
          elsif cell.is_a?(Rook)
            sum += 5
          elsif cell.is_a?(Queen)
            sum += 9
          end
        else
          if cell.is_a?(Pawn)
            sum -= 1
          elsif cell.is_a?(Bishop) || cell.is_a?(Knight)
            sum -= 3
          elsif cell.is_a?(Rook)
            sum -= 5
          elsif cell.is_a?(Queen)
            sum -= 9
          end
        end
      end
    end

    sum
  end

  def in_check?(color)
    color == :white ? other_color = :black : other_color = :white
    king_location = find_king(color)

    @grid.each do |row|
      row.each do |space|
                #  puts "space contains a #{space.class}"
        if space.color == other_color
          if space.valid_moves.include?(king_location)
            return true
          end
        end
      end
    end

    false
  end

  def find_king(color)
    @grid.each_with_index do |row, x|
      row.each_with_index do |space, y|
        return [x,y] if space.is_a?(King) && space.color == color
      end
    end
  end

  def checkmate?(color)

    @grid.each_with_index do |row, x|
      row.each_with_index do |piece, y|
        if piece.color == color
          piece.valid_moves.each do |move|
            copy = self.dup
            copy.move_piece!([x,y], move)
            return false unless copy.in_check?(color)
          end
        end
      end
    end

    true
  end

  def all_pieces_of_color(color)
    pieces = []
    @grid.each do |row|
      row.each do |cell|
        if cell.color == color
          pieces << cell
        end
      end
    end

    pieces
  end
end
