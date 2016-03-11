
require_relative 'Board.rb'
require_relative 'Player.rb'
require_relative 'Pieces.rb'
require 'byebug'
class Game

	def initialize
		@player_white = Player.new(:white)
		@player_black = Player.new(:black)
		@current_player = @player_white #assign current_player to start as white
	end 

	def setup_board
		@board = Board.new 
		@board.place_pawns
	end

	def print_board
	  @board.show_board   
	end 

	def game_over?
	  @board.in_checkmate?('black') 
	end
 
	def select_piece #returns a piece value after checking for color
		piece_is_valid = false 
		until piece_is_valid
	  	piece = @current_player.get_piece 
	    if @board.piece_select_legal?(piece, @current_player.color) 
	    	piece_is_valid = true 
		  else 
		  	p 'You can\'t select that piece.' 
		  end  
		end
		piece  #returns piece array at end, to be assigned.	
	end 

	def select_destination(piece) #rename?
		destination_is_valid = false 
		until destination_is_valid 
			destination = @current_player.get_destination 
			if @board.move_legal?(piece, destination, @current_player.color) #checks conditions for movement
				if @current_player.color == :white 
					@current_player = @player_black 
				else 
					@current_player = @player_white 
				end 
					destination_is_valid = true 
					return destination 
			else 
				puts "That's not a valid move, sorry."
				print_board 
			end 
	  end 
	end  

	def play_game
	  setup_board 
	  print_board #temporary turn counter. Will remove in final iteration.
	  until game_over? 
	  	puts " Player #{@current_player.color} -- it's your turn!"
	  	piece = select_piece 
	    # the idea here is to loop until we get a valid piece selected.
	 
		  destination = select_destination(piece) 
		 	@board.move(piece, destination)
		 	#switch players here -- method.  
	    
	  end 
	  puts 'Game over'
	end
end

chess = Game.new 
chess.play_game 
 