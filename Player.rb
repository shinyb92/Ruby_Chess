
require_relative 'Board.rb'
class Player
	attr_accessor :color

  def initialize(color)
  	@color = color 
  end

  def switch_player
    if self.color == :white 
      self.color = :black 
    elsif self.color == :black 
      self.color = :white 
    end 
  end 

  def get_row
    row_loop = true

    while row_loop 
      row = gets.chomp
      if row.to_i >= 1 && row.to_i <= 8 
        row_loop = false  
        return (row.to_i - 1) #explicit return 
      elsif row == 'exit' || row == 'quit' || row == 'q'
        puts 'Are you sure you want to quit? (yes/no)'
        answer = gets.chomp 
          if answer == 'yes' || answer == 'y'
             exit 
          elsif answer == 'no' || answer == 'n'
              #do nothing 
          end
      else  
        puts 'Please enter a number between 1 and 8'
      end
    end 
  end 

  def get_column 
    column_loop = true 

    while column_loop 
      column = gets.chomp 
        if column.to_i >= 1 && column.to_i <= 8 
          column_loop = false 
          return (column.to_i - 1) 
        elsif column == 'quit' || column == 'exit' || column =='q'
          puts 'Are you sure you want to quit? (yes/no)' 
          answer = gets.chomp 
            if answer == 'yes' || answer == 'y'
              exit
            elsif answer == 'no' || answer == 'n'
              #do nothing
            else 
              puts 'I couldn\'t understand you! Please type yes or no. (or y/n if you\'re lazy, like me.)'
            end 
        else 
          puts 'Please enter a number between 1 and 8.'
        end 
    end

  end 
    
 
  
  def get_piece #returns an array specifying what piece we are targeting. 
  	piece = [] #a little array where we store the piece's location 

  	puts 'Which piece would you like to select?'
  	puts 'Choose by row and then column.'   

    puts 'Row:'
    row = get_row 
    puts 'Column:'
    column = get_column 

    piece << row
    piece << column 

    piece 
  end


  def get_destination #returns an array to specify where we want to move.
  	destination = [] #array of destination location, to be filled. 

		puts 'Where would you like to move?' 


    puts 'Row:'
    row = get_row 
    puts 'Column:'
    column = get_column 

    destination << row 
    destination << column 

    destination 
  end 

  

end


 



