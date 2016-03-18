class SlidingPiece < Piece 

	def get_legal_moves(origin, board)
		my_class = self.class
		my_directions = my_class::DIRECTIONS

		legal_moves = [] 
		my_directions.each do |direction| 
			1.upto(8) do |moves_away|
				
				y_direction = direction[0] * moves_away 
				x_direction = direction[1] * moves_away 

				y_origin = origin[0]
				x_origin = origin[1]			

				changed_y = y_direction + y_origin
				changed_x = x_direction + x_origin
 
				new_location = [changed_y, changed_x] #a possible new location
				if board.off_board?(new_location) #we check if it's off the board.
					break 
				elsif board.piece_at(new_location).nil?#we check if the space is empty, in this case, nil specifically. 
					legal_moves << new_location 
				elsif board.piece_at(new_location).color == @color #we check if it's our current color. 
					break
				elsif board.piece_at(new_location).color != @color 
					legal_moves << new_location 
					break 
				end
			end 
		end 
		legal_moves 
	end
end

