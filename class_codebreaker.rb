require './module_common'

class CodeBreaker
    include Common
    attr_accessor :player_input_code

    def initialize
        @player_input_code = []
    end
end