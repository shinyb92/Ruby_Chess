
require_relative 'Pieces.rb'
require 'byebug'
class Board
	def initialize 
		white_rook = Rook.new(:white)
		white_knight = Knight.new(:white)
		white_bishop = Bishop.new(:white) 
		white_king = King.new(:white)
		white_queen = Queen.new(:white)
		black_rook = Rook.new(:black) 
		black_knight = Knight.new(:black)
		black_bishop = Bishop.new(:black)
		black_king = King.new(:black)
		black_queen = Queen.new(:black)


 		@grid = 
		[
		 [white_rook,  white_knight,   white_bishop,     white_king, white_queen,    white_bishop,       white_knight,  white_rook], 
	   [],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,          nil   ],
	   [   nil,         nil,           nil,           nil,          nil,              nil,                 nil,                                                                                     nil   ],	
     [],
	   [black_rook,  black_knight,   black_bishop,    black_king,      black_queen,      black_bishop, black_knight,  black_rook],
	                             ]
	                         
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
				p displayed_row.join
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
				p displayed_row.join 
			end
	  end 
	end 




	def in_checkmate?(color)
		false
	end

	#some method that will validate which pieces can be moved 
	#def validate_initial_piece(color, legality, etc.) end or something.   
	#def validate_destination  as well. 
	

	def move(piece, destination) #takes two arrays of coordinates. [0,1],[2,2] is an example.  
		current_piece = @grid[piece[0]][piece[1]] 
	 	@grid[destination[0]][destination[1]] = current_piece 
	 	@grid[piece[0]][piece[1]] = nil  
		show_board
	end

	def piece_select_legal?(piece, current_color)#checks if you can pick that piece, depending on your color
		if @grid[piece[0]][piece[1]] == nil 
			 false 
		elsif @grid[piece[0]][piece[1]].color == current_color && !@grid[piece[0]][piece[1]].get_legal_moves(piece,self).empty? #checks if there are legal moves for this piece this turn. 
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

  
	
end
























