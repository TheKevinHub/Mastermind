require './module_common'

class Board
    include Common
    attr_accessor :maker_board, :turn_count, :breaker

    def initialize
        @maker_board = []
        @breaker_board = []
        @winner = false
        @match = 0
        @partial = 0
        @codebreaker = CodeBreaker.new
        @codemaker = CodeMaker.new
        @turn_count = 1
        @test_board = Array.new(12) { Array.new(4, '_') }
        @test_checks = Array.new(12) { Array.new(2, '_') }
        puts 'Do you want to be the codebreaker or codemaker?'
        @gamemode = gets.chomp
        until @gamemode == "codebreaker" || @gamemode == "codemaker"
            puts 'Please enter codebreaker or codemaker.'
            @gamemode = gets.chomp
        end
        if @gamemode == "codebreaker"
            system "clear"
            puts "You chose to be the codebreaker."
            puts "\r"
        else
            system "clear"
            puts "You chose to be the codemaker."
            puts "\r"
        end
    end



    def display_board(board, checks)
      x = 0
      puts "\r"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      until x == 12
        puts " #{board[x][0]} | #{board[x][1]} | #{board[x][2]} | #{board[x][3]} || M: #{checks[x][0]} P: #{checks[x][1]} "
        x += 1
      end
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "\r"
    end

  
    # if player is breaker
    def player_is_breaker
        @breaker_board = @codebreaker.player_input_code
        @test_board[@turn_count-1] = @codebreaker.player_input_code
    end

    # if player is maker
    def player_is_maker
        @maker_board = @codemaker.player_input_code
        @breaker_board = @codemaker.ai_input_code
        @test_board[@turn_count-1] = @codemaker.ai_input_code
    end

    # computer generated code
    def computer_maker
        i = 1
        while i <= 4 do
            value = Common::CODE_RANGE.sample
            @maker_board << value
            i += 1
        end
    end

    # check for win
    def check_winner
        if @maker_board == @breaker_board
            @turn_count = 13
            @winner = true
        end
    end

    # check for matches and partials
    def check_match_or_partial
        @match = 0
        @partial = 0
        @maker_board.each_with_index do |a, i|
            @breaker_board.each_with_index do |b, j|
                if a == b && i == j
                    @match += 1
                elsif a == b && i != j
                    @partial += 1
                end
            end
        end
        @test_checks[@turn_count-1][0] = @match
        @test_checks[@turn_count-1][1] = @partial
    end

    # check who won
    def result
        case @gamemode
        when 'codebreaker'
            if @winner == true
                puts "Congratulations, you cracked the code!"
            else
                puts "You've run out of guesses... The code was #{@maker_board.join}."
            end
        else
            if @winner == true
                puts "Oh no, the computer has figured out your code!"
            else
                puts "You've beaten the computer!"
            end
        end
    end

    # choose which game mode to play, codebreaker or codemaker
    def decide_play_method
        case @gamemode
        when 'codebreaker'
            play_codebreaker
        else
            play_codemaker
        end
    end


    # execute if player chose to be codebreaker
    def play_codebreaker
        computer_maker
        until @turn_count >= 13
            puts "Turn: #{@turn_count}"
            @codebreaker.player_input
            player_is_breaker
            check_match_or_partial
            display_board(@test_board, @test_checks)
            check_winner
            @turn_count += 1
        end
        result
    end

    # execute if player chose to be codemaker
    def play_codemaker
        @codemaker.player_input
        @codemaker.first_guess
        @test_board[0] = @codemaker.ai_input_code
        check_match_or_partial
        display_board(@test_board, @test_checks)
        @turn_count += 1
        sleep(0.7)
        system "clear"
        until @turn_count >= 13
            puts "Turn: #{@turn_count}"
            @codemaker.solve
            player_is_maker
            check_match_or_partial
            display_board(@test_board, @test_checks)
            check_winner
            @turn_count += 1
            sleep(0.7)
            if @turn_count < 13
              system "clear"
            end
        end
        result
    end

end