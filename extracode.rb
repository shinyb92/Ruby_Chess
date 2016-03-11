#Notes: 
# -- How to save board-state? It must be stored each turn, else 
# the game will replay itself over and over from the start. 
# -- Moving pieces must be pushd into array. 
# How will I maintain the integrity of the board when this happens? 
# My guess is to replace all missing pieces with some kind of 
# nil character that represents empty space. 
# -- How to save game to file? This will be in later stages. Save for later in process. 
# -- My current idea is to have each piece be identified, 
# and then have it be put through rules of movement individual to it. 
# These "tests" will likely contain a lot of booleans 
# e.g. it will put through tests and respond based on those rules .
# e.g. if a pawn is attempting to move diagonally it will deny that. 
# if it moves two on the first turn and that condition is true AND the space is open 
# Some complications come from 

#Take gets.chomp logic -- live inside Player class from Board class 
#Take input from Player, pass to board move method, 



# until game_over?
require 'byebug' 

		def in_check?(current_color)
		if current_color == :white #check the white king, if player is player white.
			king_location = @grid.get_king_location 
			if king.can_be_taken? 
				return true 
			else 
				return false 
			end
		elsif current_color == :black #if the current player is black, check the black king
			king = @grid.get_piece(black_king)
			if king.can_be_taken?
				return true 
			else 
				return false 
			end
		end 



	def can_be_taken?(king_location,board)
		directions = [[-1,0],[1,0],[0,1],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]] 
		directions.each do |direction| 
			1.upto(8) do |moves_away|
				
				y_direction = direction[0] * moves_away 
				x_direction = direction[1] * moves_away 

				y_origin = king_location[0]
				x_origin = king_location[1]			

				changed_y = y_direction + y_origin
				changed_x = x_direction + x_origin
 
				new_location = [changed_y, changed_x]
				piece = board.piece_at(new_location)
				
				if !piece.nil? && piece.color != @color 
						if piece.get_legal_moves(new_location,board).include?(king_location)
						 	return true
					  end 
				end 
				
			end 
		end
	end 

		def get_location
		row_count = 0 
		@grid.each do |row| 
			row.each do |piece|


			end 
		end 
	end 
	
	end 




