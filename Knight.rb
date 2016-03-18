require_relative 'Piece.rb'
require_relative 'SteppingPiece.rb'
require 'byebug'
class Knight < SteppingPiece 

	DIRECTIONS = [[2,-1],[2,1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]  

	def display
		if @color == :black 
			 	" \u265E "
		elsif @color == :white
			 	" \u2658 "
		end 
	end

	def move_legal?(origin, destination,board)
		legal_moves = get_legal_moves(origin,board)
		legal_moves.include?(destination)  
	end
end 


