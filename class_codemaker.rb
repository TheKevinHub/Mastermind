require './module_common'

class CodeMaker
    include Common
    attr_accessor :player_input_code, :ai_input_code

    def initialize
        @player_input_code = []
        @ai_input_code = []
    end

    # first guess - all four values are the same
    def first_guess
        value = Common::CODE_RANGE.sample
        i = 1
        while i <= 4 do
            @ai_input_code << value
            i += 1
        end
        puts "Computer guessed: #{ai_input_code.join('')}"
    end

    # keeps matches and picks a new random number for non-matches
    def solve
        new_guess = []
        i = 0
        while i <= 3
            if @player_input_code[i] == @ai_input_code[i]
                new_guess << @player_input_code[i]
            else
                value = Common::CODE_RANGE.sample
                new_guess << value
            end
            i += 1
        end
        @ai_input_code = new_guess
        puts "Computer guessed: #{ai_input_code.join('')}"
    end
end

# Optional: Don't allow the computer to repeat numbers
# (like no_repeat() in the module_common.rb file)