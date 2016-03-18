require_relative 'Piece.rb'
require_relative 'SlidingPiece.rb'
class Bishop < SlidingPiece

	DIRECTIONS = [[-1,-1],[-1,1],[1,-1],[1,1]]
	
	def display
		if @color == :black 
			 " \u265D "
		elsif @color == :white
			 " \u2657 "
		end 
	end

	def move_legal?(origin, destination,board)
		legal_moves = get_legal_moves(origin,board)
		legal_moves.include?(destination)  
	end
 
end 


