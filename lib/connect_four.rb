# frozen_string_literal: true

require_relative "player"
require_relative "base_game"

# Connect Four Game Module
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    attr_accessor :board

    def initialize(title = "Connect Four", col = 7, row = 6)
      super(title)
      @col = col
      @row = row
      puts "Hello from #{self.class}"
    end

    def generate_board
      @board = Array.new(@row) { Array.new(@col, 0) }
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
