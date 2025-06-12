# frozen_string_literal: true

require "colorize"
require_relative "file_utils"

module ConsoleGame
  # Player class
  class Player
    @number_of_player = 0
    attr_reader :name
    attr_accessor :moves, :player_color

    def initialize(game_manager = nil, name = "", player_color = String.colors.sample)
      @game_manager = game_manager
      Player.add_player
      @name = edit_name(name)
      @moves = []
      @player_color = player_color
    end

    # Edit player name
    # @param name [String]
    def edit_name(name = "")
      return F.rs("connect4.default.player_name", { num: Player.total_player }) if name.empty?

      @name = name.colorize(player_color)
    end

    def self.add_player
      @number_of_player += 1
    end

    def self.total_player
      @number_of_player
    end
  end

  # Computer player class
  class Computer < Player
    def initialize(game_manager = nil, name = F.rs("connect4.default.ai_name"))
      super(game_manager, name)
    end
  end
end
