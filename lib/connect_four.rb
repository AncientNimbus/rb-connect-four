# frozen_string_literal: true

require_relative "player"
require_relative "base_game"
require_relative "console"

# Connect Four Game Module
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    INFO = { title: "Connect Four", ver: "v0.1.0" }.freeze

    attr_accessor :board

    def initialize(game_manager = nil, input = nil)
      super(game_manager, input, INFO[:title])
      @col = 7
      @row = 6
    end

    def generate_board
      @board = Array.new(@row) { Array.new(@col, 0) }
    end

    def setup_game
      input.handle_input(F.s("connect4.get_num"), reg: /\A[1-7]\z/, err_msg: F.s("connect4.get_num_err"))
    end
  end
end

# core game loop
# display a grid that's 7-column and 6-row
# prompt user1 for an input between 1-7, where 1 is the first column on the left, and 7 is the last column on the right
# when a valid input is received, update the column to reflect user's choice.
# print a new display to reflect the changes
# user2 or npc will take their turn
# repeat the column update process
# the game ends when a player placed four discs that are connected either vertically, horizontally or diagonally.
# announce winner
# prompt restart
# keyword: exit - exit program
# keyword: help - print how to play tooltip
