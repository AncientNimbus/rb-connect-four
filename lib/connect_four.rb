# frozen_string_literal: true

require_relative "player"
require_relative "base_game"
require_relative "console"
require_relative "connect_four_logic"

# Connect Four Game Module
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    include ConnectFourLogic
    INFO = { title: "Connect 4", ver: "v0.7.1" }.freeze

    attr_reader :p1, :p2, :bound, :combinations, :board_cap, :board_low, :sep, :e_slot, :f_slot, :empty_slots
    attr_accessor :board, :mode, :p1_turn

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
      greet(p1, p2)
      # set game board
      generate_board
      winning_combos
      print_board
      # enter game loop
      game_loop
    end

    # core game loop
    def game_loop
      toss_a_coin
      play_turn until remaining_slots.zero?
    end

    # Decide who is starting first
    def toss_a_coin
      input.std_show("connect4.pregame.msg1")
      input.handle_input(allow_empty: true)

      input.std_show("connect4.pregame.msg2")
      @p1_turn = [true, false].sample

      sleep(0.8)
      input.print_msg(F.s("connect4.pregame.msg3", { player: p1_turn ? p1.name : p2.name }), pre: "* ")
    end

    # Play turn
    def play_turn
      player = p1_turn ? p1 : p2
      input.print_msg(F.s("connect4.turn.msg1", { player: player.name }), mode: :print)

      user_col = player_choice(player)

      valid_move, user_pos = update_board(player, user_col)
      player.store_move(user_pos)

      print_board

      self.p1_turn = !p1_turn if valid_move
    end

    # Get column value from player
    # @param player [ConsoleGame::Player, ConsoleGame::Computer]
    # @return [Integer]
    def player_choice(player)
      value = nil
      if player.is_a?(Computer)
        value = player.random_move(empty_slots)
        print value
        puts
      else
        value = input.handle_input(reg: F.rs("connect4.turn.reg"), err_msg: F.s("connect4.turn.err")).to_i
      end
      value
    end

    # Generate game board as array
    def generate_board
      @bound = [7, 6]
      row, col = bound
      @board = Array.new(col) { Array.new(row, e_slot) }
    end

    # calculate all winning combinations
    def winning_combos
      @combinations = {}
      bound.reduce(:*).times do |idx|
        combinations[idx] = valid_sequences(idx)
      end
      # p combinations
    end

    # Calculate valid sequence based on positional value
    # @param value [Integer] positional value within a matrix
    # @return [Array<Array<Integer>>] an array of valid directional path within given bound
    def valid_sequences(value = 0)
      arr = []
      DIRECTIONS.each_key do |path|
        sequence = direction(value, path)
        arr << sequence unless sequence.empty?
      end
      arr
    end

    # count remaining slots
    def remaining_slots
      @empty_slots = []
      board.flatten.each_with_index { |elem, idx| empty_slots.push(idx) if elem == e_slot }

      empty_slots.size
    end

    # Update game board
    # @param player [ConsoleGame::Player, ConsoleGame::Computer]
    # @param col [Integer] column number from input
    # @param row [Integer] expecting value to starts from 0
    # @return [Array(Boolean, Array<Integer>), nil] Returns [true, position] if move is valid, or nil if column is full
    def update_board(player, col, row = 0)
      return input.print_msg(F.s("connect4.turn.col_err", { col: col }), pre: "* ") if row == 6

      real_col = col - 1
      if board[row][real_col] == e_slot
        process_move(player, real_col, row)
        [true, to_pos([row, real_col], bound)]
      else
        row += 1
        update_board(player, col, row)
      end
    end

    # Data process when move is valid
    def process_move(player, col, row)
      board[row][col] = f_slot.colorize(player.player_color)
    end

    # Print game board to console
    def print_board
      input.print_msg(board_cap, pre: "* ")
      board.reverse_each do |row|
        input.print_msg(row.join(" #{sep} "), pre: "* #{sep} ", suf: " #{sep}")
      end
      input.print_msg(board_low, pre: "* ")
      puts
    end

    # Select game mode
    def game_mode
      out = input.handle_input(F.s("connect4.mode"), reg: F.rs("connect4.mode_reg"), err_msg: F.s("connect4.mode_err"))
      self.mode = out.to_i
      input.print_msg(F.s("connect4.#{mode == 1 ? 'mode_pvp' : 'mode_pve'}"), pre: "* ")
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
      player
    end

    # Player setup depending on chosen game mode
    def player_setup
      player_profile(p1)
      @p2 = player_profile(p2)
    end

    # Greet user
    # @param player1 [ConsoleGame::Player] player class object
    # @param player2 [ConsoleGame::Player, ConsoleGame::Computer] player class or computer class object
    def greet(player1, player2)
      input.print_msg(F.s("connect4.#{mode == 1 ? 'greet_pvp' : 'greet_pve'}",
                          { p1: player1.name, p2: player2.name, title: title }))
      [player1, player2].each do |player|
        input.print_msg(F.s("connect4.assignment", { player: player.name, disc: f_slot.colorize(player.player_color) }))
      end
    end

    # Print game intro
    def show_intro
      super
      input.show("connect4.boot")
    end
  end
end

# core game loop
# the game ends when a player placed four discs that are connected either vertically, horizontally or diagonally.
# announce winner
# prompt restart
# keyword: exit - exit program
# keyword: help - print how to play tooltip
