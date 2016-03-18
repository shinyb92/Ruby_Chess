
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
					destination_is_valid = true 
					return destination 
			else 
				puts "That's not a valid move, sorry."
				print_board 
			end 
	  end 
	end


	def show_welcome_message
		puts 'Welcome to Ruby Command Line Chess.'
	  puts 'Certainly not the best way to play chess -- but the most Ruby! Guaranteed.'
	  puts 'To exit type "quit" or "exit"' 
	end  

	def play_game
	  setup_board 
	  print_board 
	  show_welcome_message 
	  until game_over?
	  	current_color = @current_player.color 
	  	if @board.is_in_check?(current_color)
	  		puts "Player #{@current_player.color} is in check! Move your King from sure destruction!"

	  		piece = @board.get_king_location(current_color)

	  		destination = select_destination(piece)
	  		@board.move(piece,destination)

	  		@current_player.switch_player 
	  	else 

	  		puts "Player #{@current_player.color} it's your turn!"

	  		piece = select_piece #grab piece 
	 
		  	destination = select_destination(piece) #select a destination on board.
		 		@board.move(piece, destination) #board moves piece to destination. 
		 		@current_player.switch_player #switches player. Black --> White / White --> Black 
		 	end  
	    
	  end 
	  puts 'Game over'
	end
end

chess = Game.new 
chess.play_game 
 