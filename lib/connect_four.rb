# frozen_string_literal: true

require_relative "player"
require_relative "base_game"
require_relative "console"

# Connect Four Game Module
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    INFO = { title: "Connect 4", ver: "v0.1.0" }.freeze

    attr_reader :p1, :p2, :board_cap, :board_low, :sep, :e_slot, :f_slot
    attr_accessor :board, :mode

    def initialize(game_manager = nil, input = nil)
      super(game_manager, input, INFO[:title])
      @p1 = game_manager.p1
      @p2 = nil

      # Board asset: cap
      @board_cap ||= fetch_board_asset("cap")
      # Board asset: low
      @board_low ||= fetch_board_asset("low")
      # Board asset: separator
      @sep ||= fetch_board_asset("sep")
      # Board asset: empty slot
      @e_slot ||= fetch_board_asset("hollow")
      # Board asset: filled slot
      @f_slot ||= fetch_board_asset("filled")
    end

    # Fetch board asset from textfile
    def fetch_board_asset(element)
      F.rs("connect4.board.#{element}")
    end

    # Sequence to setup game board
    def setup_game
      # set game mode
      game_mode
      # set player profile
      player_setup
      # set game board
      generate_board
      print_board

      # enter game loop

      # input.handle_input(F.s("connect4.turn"), reg: F.rs("connect4.turn_reg"), err_msg: F.s("connect4.turn_err"))
    end

    # Generate game board as array
    def generate_board
      @col = 7
      @row = 6
      @board = Array.new(@row) { Array.new(@col, e_slot) }
    end

    # Print game board to console
    def print_board
      input.print_msg(board_cap, pre: "* ")
      board.each do |row|
        input.print_msg(row.join(" #{sep} "), pre: "* #{sep} ", suf: " #{sep}")
      end
      input.print_msg(board_low, pre: "* ")
    end

    # Select game mode
    def game_mode
      out = input.handle_input(F.s("connect4.mode"), reg: F.rs("connect4.mode_reg"), err_msg: F.s("connect4.mode_err"))
      self.mode = out.to_i
    end

    # Set up player profile
    # @param player [ConsoleGame::Player] player class object
    # @return [ConsoleGame::Player, ConsoleGame::Computer]
    def player_profile(player)
      if player.nil?
        player = mode == 1 ? Player.new(game_manager, "") : Computer.new(game_manager)
        return player if player.is_a?(Computer)
      end
      player.edit_name(input.handle_input(F.s("connect4.name_player", { player: player.edit_name }), allow_empty: true))
      greet(player)
      player
    end

    # Player setup depending on chosen game mode
    def player_setup
      player_profile(p1)
      @p2 = player_profile(p2)
    end

    # Greet user
    # @param player [ConsoleGame::Player] player class object
    def greet(player)
      input.print_msg(F.s("connect4.greet", { player: player.name, title: title }))
    end

    # Print game intro
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
