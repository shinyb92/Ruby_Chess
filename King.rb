require_relative 'Piece.rb'
require_relative 'SteppingPiece.rb'

class King < SteppingPiece

	DIRECTIONS = [[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1],[1,1]]  

	def display
		if @color == :black 
			" \u265A "
		elsif @color == :white
			 " \u2654 "
		end 
	end

	def move_legal?(origin, destination,board)
		legal_moves = get_legal_moves(origin,board)
		legal_moves.include?(destination)  
	end


 

end 