# frozen_string_literal: true

require_relative "player"

# Connect Four Game Module
module ConnectFour
  # ConnectFour::Board class
  class Board
    attr_accessor :board

    def initialize(col = 7, row = 6)
      @col = col
      @row = row
    end

    def generate_board
      @board = Array.new(@row) { Array.new(@col, 0) }
    end
  end

  # ConnectFour::Controller class
  class Controller
    attr_reader :game, :p1

    # @todo console input control

    def initialize(game = Board.new, player1 = ConsoleGame::Player.new)
      @game = game
      @p1 = player1
    end

    # prompt user to collect input
    # @param reg [Regexp] patter to match
    # @param msg [String] first print
    # @param err_msg [String] second print
    def prompt_user(reg = /.*/, msg = "Provide an input: ", err_msg = "Invalid input, please try again: ")
      input = ""
      loop do
        msg_printer(msg)
        input = gets.chomp
        break if input.match?(reg) && !input.empty?

        msg = err_msg
      end
      input
    end

    # prompt message helper
    # @param msg [String] message to print
    # @param pre [String] message prefix
    # @param suf [String] message suffix
    # @param mode [Symbol] expecting the following symbols: `puts`, `print`, `p`
    def msg_printer(msg = "Using message printer", pre: "* ", suf: "", mode: :puts)
      return ArgumentError("Invalid mode used for this method") unless %i[puts print p].include?(mode)

      formatted_msg = pre + msg + suf
      method(mode).call(formatted_msg)
    end
  end
end

cf = ConnectFour::Controller.new

cf.prompt_user

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
