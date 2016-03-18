require_relative 'Pieces.rb'
require 'byebug'
class Board
	def initialize 
		white_rook_left = Rook.new(:white) #left and right rooks,bishops, and knights are to differentiate them as distinct objects of the same class. Distinction needed for location methods. 
		white_rook_right = Rook.new(:white)
		white_knight_left = Knight.new(:white)
		white_knight_right = Knight.new(:white)
		white_bishop_left = Bishop.new(:white) 
		white_bishop_right = Bishop.new(:white)
		white_king = King.new(:white)
		white_queen = Queen.new(:white)
		black_rook_left = Rook.new(:black) 
		black_rook_right = Rook.new(:black)
		black_knight_left = Knight.new(:black)
		black_knight_right = Knight.new(:black)
		black_bishop_right = Bishop.new(:black)
		black_bishop_left = Bishop.new(:black)
		black_king = King.new(:black)
		black_queen = Queen.new(:black)




 		@grid = 
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
		self.place_pawns 	                                                                              
	end

	def display_bottom_key 
		puts "   1  2  3  4  5  6  7  8" 
	end 

	def place_pawns
		1.upto(8) do #fills second row with white pawns 
			@grid[1] << Pawn.new(:white) 
		end

		1.upto(8) do #fills second row from bottom with black pawns 
			@grid[6] << Pawn.new(:black)
		end 
	end

	def show_board 
		square_count = 0 #keeps track of the number value of square.
		row_number = 1 #keeps track of the row number we're on. 
		@grid.each do |row|
			if row_number % 2 == 0  #even rows 
				displayed_row = row.map do |piece| 
					if piece.nil? && square_count == 0  
						square_count += 1 
						" \u25A2 "
					elsif piece.nil? && square_count == 1 
						square_count += 1
						" \u25A5 "
					elsif piece.nil? && square_count % 2 == 0 
						square_count += 1
						" \u25A2 "
					elsif piece.nil? && square_count % 2 != 0 
						square_count += 1
						" \u25A5 "
					else 
						square_count += 1
						piece.display 
					end  
				end 
				row_number += 1 #adds to total row count.
				row_number_displayed = (row_number - 1).to_s  
			  p row_number_displayed +  displayed_row.join
			else #this code activates on odd rows
				displayed_row = row.map do |piece|
					if piece.nil? && square_count % 2 == 0 
						square_count += 1 
						" \u25A5 "
					elsif piece.nil? && square_count % 2 != 0
						square_count += 1  
						" \u25A2 "
					else 
						square_count += 1
						piece.display 
					end  
				end
				row_number += 1
				row_number_displayed = (row_number - 1).to_s
			  p row_number_displayed +  displayed_row.join 
			end
	  end
	  self.display_bottom_key 
	end 

	def in_checkmate?(color)
		false
	end

	def move(piece, destination) #takes two arrays of coordinates. [0,1],[2,2] is an example.  
		current_piece = @grid[piece[0]][piece[1]] 
	 	@grid[destination[0]][destination[1]] = current_piece 
	 	@grid[piece[0]][piece[1]] = nil  
		show_board
	end

	def piece_select_legal?(piece, current_color)
		#checks if you can pick that piece, depending on your color
		selected_piece = @grid[piece[0]][piece[1]]
		if selected_piece == nil 
			 false  
		elsif selected_piece.color == current_color && !selected_piece.get_legal_moves(piece,self).empty? #checks if there are legal moves for this piece this turn. 
		  true
		else 
			false 
		end 
	end

	def off_board?(destination)
	  row = destination[0]
	  column = destination[1]
	  if row < 0 || row > 7 
	  	return true 
	  elsif column < 0 || column > 7 
	  	return true
	  else 
	  	return false 
	  end 
	end 

	def put_rooks
		white_rook_left = @grid[0][0]
		white_rook_right = @grid[0][7]
		p white_rook_left 
		p white_rook_right 
	end 


	
	def move_legal?(origin, destination, current_color)
		piece = @grid[origin[0]][origin[1]]#this gives us whatever is at the origin's arrays coordinates. e.g. [0,1] -- @grid[0][1] -- meaning first row, second piece
		destination_is_possible = piece.move_legal?(origin, destination,self) #here we check if that is OK to move to.

		return destination_is_possible
	end

	def piece_at(location)
		@grid[location[0]][location[1]] #returns whatever object is at that coordinate.
	end

	def get_king_location(current_color)
		row_count = 0 
		@grid.each do |row|
			row.each do |piece| 
				if piece.class == King && piece.color == current_color
					 king_location = [row_count,row.index(piece)]
					 return king_location #once it finds the king we don't need anymore locations, that's the one!
				end 
			end
			row_count += 1 #if it doesn't find a king on the row, add one to total rows, so row_count is accurate. 
		end 
	end 

		def get_location(desired_piece)
				row_count = 0
		@grid.each do |row|  
			row.each do |piece| 
				if piece == desired_piece 
					piece_location = [row_count,row.index(piece)]
					return piece_location
				end  
			end
			row_count += 1  
	end 
	end 


	def king_can_be_taken?(king_location,current_color) 
		@grid.each do |row|
			row.each do |piece|
				piece_location = self.get_location(piece) 
					if !piece.nil? && piece.color != current_color  
						legal_moves = piece.get_legal_moves(piece_location,self)
						if legal_moves.include?(king_location)
							return true 
						end 
					end 
			end
		end
		return false 
	end

	def is_in_check?(current_color)
    if current_color == :white #check the white king, if player is player white.
      king_location = self.get_king_location(current_color)
      if self.king_can_be_taken?(king_location,current_color) 
        return true 
      else 
        return false 
      end
    elsif current_color == :black #if the current player is black, check the black king
      king_location = self.get_king_location(current_color)
      if self.king_can_be_taken?(king_location,current_color)
        return true 
      else 
        return false 
      end
    end
  end 


	def is_not_vertical_to_pawn?(pawn_location,piece_location,current_color) #means that if you want to move [2,0], let's say, there isn't a piece in front of you.
		pawn_y = pawn_location[0]
		pawn_x = pawn_location[1]

 

	  if current_color == :white 
		  one_vertical_space_down  = [pawn_y + 1, pawn_x]
		  two_vertical_spaces_down = [pawn_y + 2, pawn_x]
		else 
			one_vertical_space_down  = [pawn_y - 1, pawn_x]
			two_vertical_spaces_down = [pawn_y - 2, pawn_x]
		end 

		if piece_location == one_vertical_space_down || piece_location == two_vertical_spaces_down 
			return false
		else
			return true 
		end 
	end 

	def path_clear?(pawn_origin, pawn_color)
		pawn_y = pawn_origin[0]
		pawn_x = pawn_origin[1]

		if pawn_color == :white
			piece_in_path_y = pawn_y +1
			piece_in_path_x = pawn_x
		elsif pawn_color == :black
			piece_in_path_y = pawn_y - 1 
			piece_in_path_x = pawn_x 
		end  

		piece_in_path_location = [piece_in_path_y, piece_in_path_x]

		piece_in_path = self.piece_at(piece_in_path_location)

		if piece_in_path.nil?
			return true 
		else 
			return false 
		end
	end 


end









 




































