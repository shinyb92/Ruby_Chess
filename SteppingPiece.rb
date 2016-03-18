class SteppingPiece < Piece 

	def get_legal_moves(origin, board)
		my_class = self.class 
		my_directions = my_class::DIRECTIONS
		legal_moves = [] 
		my_directions.each do |direction|  
				
				y_direction = direction[0]  
				x_direction = direction[1] 

				y_origin = origin[0]
				x_origin = origin[1]			

				changed_y = y_direction + y_origin
				changed_x = x_direction + x_origin
 
				new_location = [changed_y, changed_x]

				if board.off_board?(new_location)
					next 
				elsif board.piece_at(new_location).nil? 
					legal_moves << new_location 
				elsif board.piece_at(new_location).color != @color 
					legal_moves << new_location 
				end 
		end
		legal_moves 
	end
end 