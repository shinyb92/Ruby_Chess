require_relative 'Board.rb'
class Player
	attr_accessor :color 
  def initialize(color)
  	@color = color 
  end  
  
  def get_piece #returns an array specifying what piece we are targeting. 
  	piece = [] #a little array where we store the piece's location 

  	puts 'Which piece would you like to select?'
  	puts 'Choose by row and then column.'

  	row_loop = true #keeps asking you for a row number, until valid. 
  	column_loop = true # same here for the column

  		while row_loop #MAKE SURE TO UPDATE ALL COLUMN/ROW LOOPS WITH EXIT FUNCTIONALITY. 
  			puts 'Row?'
  			row = gets.chomp
          if row.to_i >= 1 && row.to_i <= 8 
            piece << row.to_i - 1 #This abstracts the Ruby array logic from User. Usually, a Ruby user would know that arrays start at 0. But I'm not building for them! E.g. -- putting in 1 will actually give us 0 into the array, the proper element. But the user understands it as the first row.  
            row_loop = false 
  			 elsif row == 'exit' || row == 'quit' || row == 'q'
            puts 'Are you sure you want to quit? (yes/no).'
            answer = gets.chomp 
            if answer == 'yes' || answer == 'y'
              exit 
            elsif answer == 'no' || answer == 'n'
              
            end 
          else  
  			   puts 'Please enter a number between 1 and 8'
  			 end
  		end

  		while column_loop 
  			puts 'Column?'
  			column = gets.chomp.to_i 
  			if column >= 1 && column <= 8 
  				piece << column - 1 
  				column_loop = false 
  			else 
  				puts 'Please enter a number between 1 and 8.'
  			end 
  		end	
       piece  
  	end

  	def get_destination #returns an array to specify where we want to move.
  		destination = [] #array of destination location, to be filled. 

  		puts 'Where would you like to move?' 
  		puts 'Row?'

  		row_loop = true
  		column_loop = true

  		while row_loop 
  			move_row = gets.chomp
  			if move_row.to_i >= 1 && move_row.to_i <= 8 
  				destination << move_row.to_i - 1  
  				row_loop = false 
  			else
  				puts 'Please enter a number between 1 and 8.'
  			end 
  		end 

  		while column_loop
  			puts 'Column?'
  			move_column = gets.chomp.to_i 
  			if move_column >= 1 && move_column <= 8 
  				destination << move_column - 1
  				column_loop = false 
  			else 
  				puts 'Please enter a number between 1 and 8.'
  			end 
  		end
      destination 
  	end  
end

 



