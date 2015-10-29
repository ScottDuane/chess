require 'byebug'

class ComputerPlayer < Player 
    PIECE_VALUES = { King => 0, 
                    Queen => 9,
                    Rook => 5, 
                    Bishop => 3,
                    Knight => 3,
                    Pawn => 1}

    def get_move
        copy_board = @game.board.dup 
        best_result = minimax(copy_board, 2, self.color)
        best_result[0]
    end 
    
    #this is returning only the end coordinates of each move, not a pair of coordinates 
    def possible_moves(board, my_color)
        poss = [] 
        board.grid.each_with_index do |col, x| 
            col.each_with_index do |cell, y|
                if cell.color == my_color 
                    poss_for_cell = cell.valid_moves
                    poss_for_cell.each do |move|
                        poss << [[y,x], move]
                    end 
                end 
            end 
        end 
        #puts "Possible moves are #{poss}"
        poss 
    end
    
    def position_score(position, my_color)
        my_color == :white ? opp_color = :black : opp_color = :white 
        my_score = 0
        opp_score = 0
        @game.board.grid.each do |col| 
            col.each do |cell| 
                if cell.color == my_color 
                    my_score += PIECE_VALUES[cell.class]
                elsif cell.color == opp_color
                    opp_score += PIECE_VALUES[cell.class]
                end 
            end
        end
        
        my_score - opp_score
    end 
    
    def minimax(board, depth, turn_color)
        #debugger
        return [[], position_score(board, turn_color)] if depth == 0 || board.checkmate?(turn_color)
        poss_moves = possible_moves(board, turn_color)        
        if turn_color == self.color 
            best_score = -100000000
            best_move = nil 

            if !poss_moves.empty?
                poss_moves.each do |move| 
                    copy_board = board.dup 
                    can_move = copy_board.make_move(move[0], move[1], self.color)
                    if can_move
                        result = minimax(copy_board, depth-1, @opp_color)
                        if result[1] > best_score
                            best_score = result[1]
                            best_move = move 
                        end 
                    end 
                end
            end 
            return [best_move, best_score]
        elsif turn_color == @opp_color
            best_score = 100000000
            best_move = nil 

            poss_moves.each do |move| 
                copy_board = board.dup 
                can_move = copy_board.make_move(move[0], move[1], @opp_color)
                if can_move
                    result = minimax(copy_board, depth-1, self.color)
                    if result[1] < best_score
                        best_score = result[1]
                        best_move = move 
                    end 
                end 
            end
            return [best_move, best_score]
        end

    end 
    
    
end 