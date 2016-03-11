require_relative 'Piece.rb'
require 'byebug'
class Knight < Piece 
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

	def get_legal_moves(origin, board)
		directions = [[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2],[1,2],[2,1]]
		legal_moves = [] 
		directions.each do |direction| 
				
				y_direction = direction[0]  
				x_direction = direction[1] 

				y_origin = origin[0]
				x_origin = origin[1]			

				changed_y = y_direction + y_origin
				changed_x = x_direction + x_origin
 
				new_location = [changed_y, changed_x]

				if board.off_board?(new_location) #we check if it's off the board.
						
				elsif board.piece_at(new_location).nil?#we check if the space is empty, in this case, nil specifically. 
					legal_moves << new_location 
				elsif board.piece_at(new_location).color == @color #we check if it's our current color. 
				
				elsif board.piece_at(new_location).color != @color 
					legal_moves << new_location 
				end 
		end 
		legal_moves 
	end
end 


