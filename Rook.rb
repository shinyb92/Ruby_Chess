require_relative 'Piece.rb'
require_relative 'SlidingPiece.rb'

class Rook < SlidingPiece 

	DIRECTIONS = [[-1,0],[1,0],[0,1],[0,-1]]

	def display
			if @color == :black 
			 " \u265C "
			elsif @color == :white
			 " \u2656 "
		end 
	end 

	def move_legal?(origin, destination,board)
		legal_moves = get_legal_moves(origin,board)
		legal_moves.include?(destination)  
	end
end



