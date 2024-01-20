module Common
    CODE_RANGE = ['1', '2', '3', '4', '5', '6']

    def player_input
        puts 'Enter your code of four digits from one to six (example: "1536")'
        input = gets.chomp.to_i
        until no_repeat(input) == true && in_range(input) == true
          input = gets.chomp.to_i
        end
        @player_input_code = input.to_s.split('')
        sleep(3)
        system "clear"
    end

    def no_repeat(x)
      x = x.to_s.split('')
      i = 0
      while i < x.length
        if x[i].to_s == x[i + 1]
          puts "No repeats allowed. Please try again."
          return false
        end
        i += 1
      end
      true
    end

    def in_range(x)
      x = x.to_s.split('').map(&:to_i)
      i = 0
      while i < x.length
        if x[i] == 0 || x[i] > 6
          puts "No 0, 7, 8, or 9 allowed. Please try again."
          return false
        end
        i += 1
      end
      true
    end
end