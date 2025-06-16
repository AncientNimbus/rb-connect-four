# frozen_string_literal: true

require_relative "player"
require_relative "base_game"
require_relative "console"
require_relative "connect_four_logic"

# Connect Four Game Module
# @author Ancient Nimbus
module ConsoleGame
  # Connect Four the game
  class ConnectFour < BaseGame
    include ConnectFourLogic
    # Game info
    INFO = { title: "Connect 4", ver: "v0.8.6" }.freeze

    attr_reader :p1, :p2, :bound, :combinations, :board_cap, :board_low, :sep, :e_slot, :f_slot, :empty_slots
    attr_accessor :board, :mode, :p1_turn, :has_winner

    def initialize(game_manager = nil, input = nil)
      super(game_manager, input, INFO[:title])
      @p2 = nil
      @has_winner = false

      @bound = [7, 6]
      @board_cap, @board_low, @sep, @e_slot, @f_slot = tf_fetcher("board", *%w[cap low sep hollow filled])
    end

    # Textfile strings fetcher
    # @param sub [String]
    # @param keys [Array<String>] key
    # @return [Array<String>] array of textfile strings
    def tf_fetcher(sub, *keys)
      keys.map { |key| F.rs("connect4#{".#{sub}"}.#{key}") }
    end

    # Sequence to setup game session
    def setup_game
      game_mode

      player_setup
      greet(p1, p2)

      generate_board
      winning_combos
      print_board

      play
    end

    # Play a game session
    def play
      toss_a_coin
      play_turn until has_winner || remaining_slots.zero?
      end_game
    end

    # Decide who is starting first
    def toss_a_coin
      input.std_show("connect4.pregame.msg1")
      input.handle_input(allow_empty: true)

      input.std_show("connect4.pregame.msg2")
      @p1_turn = [true, false].sample

      input.print_msg(F.s("connect4.pregame.msg3", { player: p1_turn ? p1.name : p2.name }), pre: "* ", delay: 0.8)
    end

    # Play turn (Core loop)
    def play_turn
      player = p1_turn ? p1 : p2
      user_col = player_choice(player)

      valid_move, _user_pos = update_board(player, user_col)
      self.has_winner = four_in_a_row?(player)

      print_board
      self.p1_turn = !p1_turn if valid_move && !has_winner
    end

    # Get column value from player
    # @param player [ConsoleGame::Player, ConsoleGame::Computer]
    # @return [Integer]
    def player_choice(player)
      input.print_msg(F.s("connect4.turn.msg1", { player: player.name }), mode: :print)
      if player.is_a?(Computer)
        player.random_move(empty_slots, bound)
      else
        input.handle_input(reg: F.rs("connect4.turn.reg"), err_msg: F.s("connect4.turn.err")).to_i
      end
    end

    # Generate game board as array
    def generate_board
      @board = Array.new(bound[1]) { Array.new(bound[0], e_slot) }
    end

    # count remaining slots
    def remaining_slots
      filled = p1.data.fetch(:moves) + p2.data.fetch(:moves)
      @empty_slots = combinations.keys - filled
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
        pos = process_move(player, row, real_col)
        [true, pos]
      else
        row += 1
        update_board(player, col, row)
      end
    end

    # Data process when move is valid
    def process_move(player, row, col)
      board[row][col] = f_slot.colorize(player.player_color)
      pos = to_pos([row, col], bound)

      player.store_move(pos)
      player.update_turn_count

      pos
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

    # End game handling
    def end_game(result = { winner: nil, loser: nil })
      if has_winner
        result[:winner] = p1_turn ? p1 : p2
        result[:loser] = p1_turn ? p2 : p1
      else
        result[:winner] = :tie
      end
      super(result)
    end

    def show_end_screen
      winner = game_result.fetch(:winner)
      loser = game_result.fetch(:loser)
      return input.std_show("connect4.endgame.tie") if winner == :tie

      input.print_msg(F.s("connect4.endgame.player", { p1: winner.name, p2: loser.name, turn: winner.data[:turn] }))
    end

    def restart
      msg, err, reg = tf_fetcher("restart", *%w[msg1 msg1_err reg])
      out = input.handle_input(msg, err_msg: err, reg: Regexp.new(reg, "i"))
      p out
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
      player ||= mode == 1 ? Player.new(game_manager, "") : Computer.new(game_manager)

      return player if player.is_a?(Computer)

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

# prompt restart
# Clear player & Reset game state
# keyword: exit - exit program
# keyword: help - print how to play tooltip
