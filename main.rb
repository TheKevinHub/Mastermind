require './instructions'
require './class_game'
require './class_board'
require './class_codebreaker'
require './class_codemaker'
require './module_common'

game = Game.new
game.board.decide_play_method
game.play_again