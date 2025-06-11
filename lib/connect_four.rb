# frozen_string_literal: true

require_relative "player"
require_relative "base_game"
require_relative "console"

# Connect Four Game Module
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    INFO = { title: "Connect 4", ver: "v0.1.0" }.freeze

    attr_reader :p1, :p2
    attr_accessor :board, :mode

    def initialize(game_manager = nil, input = nil)
      super(game_manager, input, INFO[:title])
      @p1 = game_manager.p1
      @p2 = nil
      @col = 7
      @row = 6
    end

    def generate_board
      @board = Array.new(@row) { Array.new(@col, 0) }
    end

    def setup_game
      # set game mode
      game_mode

      # set player profile
      player_profile

      # set game board

      # enter game loop

      # input.handle_input(F.s("connect4.turn"), reg: F.rs("connect4.turn_reg"), err_msg: F.s("connect4.turn_err"))
    end

    # Select game mode
    def game_mode
      out = input.handle_input(F.s("connect4.mode"), reg: F.rs("connect4.mode_reg"), err_msg: F.s("connect4.mode_err"))
      self.mode = out.to_i
    end

    def player_profile
      p1.edit_name(input.handle_input(F.s("connect4.name_player", { player: p1.name }), allow_empty: true))
      input.print_msg(F.s("connect4.greet", { player: p1.name.capitalize, title: title }, :yellow))

      return unless mode == 1

      @p2 = Player.new(game_manager)
      p2.edit_name(input.handle_input(F.s("connect4.name_player", { player: p2.name }), allow_empty: true))
      input.print_msg(F.s("connect4.greet", { player: p2.name.capitalize, title: title }, :magenta))
    end

    def show_intro
      super
      input.show("connect4.boot")
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
