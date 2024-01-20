require './class_board'

class Game
  attr_accessor :board
  
  @@turn_count = 1

  def initialize
      @board = Board.new
  end

  def play_again
      puts "Do you want to play again?"
      answer = gets.chomp
      until answer.downcase == 'yes' || answer.downcase == 'no'
          puts "Did you mean 'yes' or 'no'?"
          answer = gets.chomp
      end
      case answer
      when 'yes'
          puts "Okay, let's play again!"
          @board = Board.new
          @board.decide_play_method
          play_again
      else
          puts "Thanks for playing! We hope you come back soon."
      end
  end

end