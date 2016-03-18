require 'byebug'
	def get_legal_moves(origin)
		directions = [[-1,0],[1,0],[0,1],[0,-1]]
		legal_moves = [] 
		directions.each do |direction| 
			1.upto(8) do |moves_away| 
				y_direction = direction[0] * moves_away 
				x_direction = direction[1] * moves_away 

				y_origin = origin[0]
				x_origin = origin[1]			

				changed_y = y_direction + y_origin
				changed_x = x_direction + x_origin

				new_location = [changed_y, changed_x]
				
			  legal_moves << new_location 
			end 
		end 
		legal_moves 
	end
