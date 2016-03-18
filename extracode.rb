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

		def is_in_check?(current_color)
		if current_color == :white #check the white king, if player is player white.
			king_location = @grid.get_king_location(:white) 
			king = board.piece_at(king_location)
			if king.can_be_taken?(king_location,board,current_color) 
				return true 
			else 
				return false 
			end
		elsif current_color == :black #if the current player is black, check the black king
			king_location = @grid.get_king_location(:black)
			king = board.piece_at(king_location)
			if king.can_be_taken?(king_locaation,board,current_color)
				return true 
			else 
				return false 
			end
		end 

 
 
	


	def can_be_taken?(king_location,board,current_color)
		king = board.piece_at(king_location)
		@grid.each do |row|
			row.each do |piece|
				piece_location = board.get_location(piece) 
					if !piece.nil? && piece.color != @color 
						legal_moves = piece.get_legal_moves(piece_location,board)
						if legal_moves.include?(king_location)
							return true 
						end 
					end 
			end
		end 
	end 


def can_be_taken?(king_location,board)
	board.loop_through_each_row 
		find pieces 
		check if they're opposite color -- if they are -- 
		check if they contain the king's location in their legal moves 
		if they do -- return true, (but before that, make a method so that you can determine whether or not the king CAN move safely to one of its legal moves -- e.g. Does the King's legal moves, passed into this method, recursively, not come up with in_check?, if none of them do, then you're essentially in checkmate, because you can't move safely to any of your legal_moves, without being in_check again.) for the function 
		if it doesn't, return false 
		go to next piece, do it all over again. 
			if it doesn't find ANY piece that can threaten the king, just 
				return false 

end

also make note that while in_check is true, the choice of the player's piece select MUST 
be the king. Make this flow in Chess.rb. e.g. when In_check == true 
piece = @grid[king_location[0]][king_location[1]], for instance. 
All of this logic will have to be written into the game flow, but it should be pretty straightforward. 
Also have some sort of message like -- "Player #{@current_player.color}! You're in check! Save your King from destruction!" 


 until game_over?
	  	if @current_player.is_in_check? 
	  		puts "Player #{@current_player.color} is in check! Move your King from sure destruction!"

	  		piece = board.get_king_location(@current_player.color)

	  		destination = select_destination(piece)
	  		@board.move(piece,destination)

	  		@current_player.switch_player 
	  else 

	  	piece = select_piece #grab piece 
	 
		  destination = select_destination(piece) #select a destination on board.
		 	@board.move(piece, destination) #board moves piece to destination. 
		 	@current_player.switch_player #switches player. Black --> White / White --> Black 
		 	end  
	    
	  end




	def get_location(current_color, desired_piece)
		@grid.each do |row|
		row_count = 0  
			row.each do |piece| 
				if piece == desired_piece 
					piece_location = [row_count,row.index(piece)]
					return piece_location 
				end 
			end 
			row_count += 1 
		end 
		
	end



STANDARD BOARD: 
[
		 [white_rook_left,  white_knight_left,   white_bishop_left,     white_king, white_queen,    white_bishop_right,       white_knight_right,  white_rook_right], 
	   [],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,                                                                                     nil   ],	
     [],
	   [black_rook_left,  black_knight_left,   black_bishop_left,    black_king,      black_queen,      black_bishop_right, black_knight_right,  black_rook_right],
	                             ]

