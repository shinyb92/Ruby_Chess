require_relative 'Piece.rb'
require 'byebug'
class Pawn < Piece

	attr_accessor :first_turn 

	def initialize(color) 
		@first_turn = true 
		@color = color 
	end  

	def display
		if @color == :black 
			 " \u265F "
		elsif @color == :white
			 " \u2659 "
		end 
	end

	def move_legal?(origin, destination,board)
		legal_moves = get_legal_moves(origin,board)
		if legal_moves.include?(destination)  
			self.first_turn = false 
			return true 
		else 
			return false 
		end 
	end

	def first_move?
		@first_turn  
	end

	def can_take_left?(origin, board)
		if self.color == :white 
			left_x = -1 
			left_y = 1 

			diagonal_left = [origin[0]+left_y, origin[1]+left_x]

			if !board.piece_at(diagonal_left).nil? && board.piece_at(diagonal_left).color != @color 
				true 
			else 
				false  
			end

		elsif self.color == :black 
			left_x = -1
			left_y = -1 

			diagonal_left = [origin[0]+left_y,origin[1]+left_x]

			if !board.piece_at(diagonal_left).nil? && board.piece_at(diagonal_left).color != @color
				true 
			else 
				false 
			end 
		end
	end

	def can_take_right?(origin,board)
		if self.color == :white
			right_x = 1 
			right_y = 1

			diagonal_right = [origin[0]+right_y, origin[1]+right_x]

			if !board.piece_at(diagonal_right).nil? && board.piece_at(diagonal_right).color != @color
				true 
			else 
				false 
			end  
		elsif self.color == :black #if the piece is :black instead. 
			right_x = 1 
			right_y = -1

			diagonal_right = [origin[0]+right_y, origin[1]+right_x]

			if !board.piece_at(diagonal_right).nil? && board.piece_at(diagonal_right).color != @color 
				true 
			else 
				false 
			end 
		end 
	end 

	
	def current_available_directions(origin, board)
		directions = []
			if self.first_move? && self.color == :white 
				if self.can_take_both_left_and_right?(origin,board)
				 	directions = [[1,0], [2,0],[1,1],[1,-1]]
				elsif self.can_take_right?(origin,board)
					directions = [[1,0],[2,0],[1,1]]
				elsif self.can_take_left?(origin,board)
					directions = [[1,0],[2,0],[1,-1]]
				else 
					directions = [[1,0],[2,0]]
				end 
				return directions 
			elsif self.first_move? && self.color == :black 
					if self.can_take_both_left_and_right?(origin,board)
						directions =[[-1,0],[-2,0],[-1,-1],[-1,1]]
					elsif self.can_take_right?(origin,board)
						directions =[[-1,0],[-2,0],[-1,1]]
					elsif self.can_take_left?(origin,board)
						directions =[[-1,0],[-2,0],[-1,-1]]
					else 
						directions = [[-1,0],[-2,0]]
					end 
					return directions 
			else 
				if self.color == :white && self.can_take_both_left_and_right?(origin,board)
					directions = [[1,0],[1,-1],[1,1]]
				elsif self.color == :white && self.can_take_left?(origin,board)
					directions = [[1,0],[1,-1]]
				elsif self.color == :white && self.can_take_right?(origin,board)
					directions = [[1,0],[1,1]]
				elsif self.color == :black && self.can_take_both_left_and_right?(origin,board)
					directions = [[-1,0],[-1,1],[-1,-1]]
				elsif self.color == :black && self.can_take_left?(origin,board)
					directions = [[-1,0],[-1,-1]]
				elsif self.color == :black && self.can_take_right?(origin,board)
					directions = [[-1,0],[-1,1]]
				elsif self.color == :black 
					directions = [[-1,0]]
				elsif self.color == :white 
					directions = [[1,0]]
				end  
				return directions    
			end
	end 


	def get_legal_moves(origin, board)
			color = self.color 
			directions = current_available_directions(origin,board) 
			legal_moves = [] 
			directions.each do |direction| 

					y_direction = direction[0]  
					x_direction = direction[1] 

					y_origin = origin[0] #starting Y-position 
					x_origin = origin[1]	#starting X-position 		

					changed_y = y_direction + y_origin #the possible change y direction
					changed_x = x_direction + x_origin #the possible change x direction 
	 
					new_location = [changed_y, changed_x]

					if board.piece_at(new_location).nil? && board.path_clear?(origin, color)
						legal_moves << new_location
					elsif board.piece_at(new_location).color != @color && board.is_not_vertical_to_pawn?(origin, new_location,color)
						legal_moves << new_location 
					end 

			end 
				legal_moves
	end

	def can_take_both_left_and_right?(origin,board)
		can_take_left = false 
		can_take_right = false 

		if self.color == :white 
			left_x = -1 
			left_y = 1 

			diagonal_left = [origin[0]+left_y, origin[1]+left_x]

			if !board.piece_at(diagonal_left).nil? && board.piece_at(diagonal_left).color != @color 
				can_take_left = true 
			else 
				can_take_left = false  
			end

		elsif self.color == :black
			left_x = -1
			left_y = -1 

			diagonal_left = [origin[0]+left_y,origin[1]+left_x]

			if !board.piece_at(diagonal_left).nil? && board.piece_at(diagonal_left).color != @color
				can_take_left = true 
			else 
				can_take_let = false 
			end 
		end

		if self.color == :white
			right_x = 1 
			right_y = 1

			diagonal_right = [origin[0]+right_y, origin[1]+right_x]

			if !board.piece_at(diagonal_right).nil? && board.piece_at(diagonal_right).color != @color
				can_take_right = true 
			else 
				can_take_right = false 
			end  
		elsif self.color == :black#if the piece is :black instead. 
			right_x = 1 
			right_y = -1

			diagonal_right = [origin[0]+right_y, origin[1]+right_x]

			if !board.piece_at(diagonal_right).nil? && board.piece_at(diagonal_right).color != @color 
				can_take_right = true 
			else 
				can_take_right = false 
			end 
		end

		if can_take_right && can_take_left 
			return true 
		else 
			return false 
		end
  end

end







