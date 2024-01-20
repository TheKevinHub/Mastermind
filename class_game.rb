class Game
    @@turn_count = 1
    # more class variables
  
    def initialize
        puts 'Do you want to be the codebreaker or codemaker?'
        @choice = gets.chomp
        until @choice == "codebreaker" || @choice == "codemaker"
            puts 'Please enter codebreaker or codemaker.'
            @choice = gets.chomp
        end
        if @choice == "codebreaker"
            puts "You chose to be the codebreaker."
            # play_codebreaker
        else
            puts "You chose to be the codemaker."
            # play_codemaker
        end
        @board = Array.new(12) { Array.new(4, '_') }
    end
  
    def display_board(board)
      x = 0
      puts "\r"
      puts "~~~~~~~~~~~~~~~"
      until x == 12
        puts " #{board[x][0]} | #{board[x][1]} | #{board[x][2]} | #{board[x][3]} "
        x += 1
      end
      puts "~~~~~~~~~~~~~~~"
      puts "\r"
    end
  
    def play_game
        display_board(@board)
    end
  
  end
