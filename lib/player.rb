# frozen_string_literal: true

require "colorize"
require_relative "file_utils"

module ConsoleGame
  # Player class
  class Player
    @number_of_player = 0
    @colors = String.colors
    class << self
      attr_reader :colors

      # Add Player count
      def add_player
        @number_of_player += 1
      end

      # Return number of active players
      def total_player
        @number_of_player
      end

      # Setup color array and remove unwanted color options
      def setup_color
        %i[default gray].each { |elem| remove_color(elem) }
      end

      # @param color [Symbol]
      def remove_color(color)
        @colors.delete(color)
      end
    end

    attr_reader :name
    attr_accessor :moves, :player_color

    def initialize(game_manager = nil, name = "")
      @game_manager = game_manager
      Player.setup_color
      Player.add_player
      @name = edit_name(name)
      @moves = []
      @player_color = Player.remove_color(Player.colors.sample)
    end

    # Edit player name
    # @param name [String]
    def edit_name(name = "")
      return F.rs("connect4.default.player_name", { num: Player.total_player }) if name.empty?

      @name = name.colorize(player_color)
    end
  end

  # Computer player class
  class Computer < Player
    def initialize(game_manager = nil, name = F.rs("connect4.default.ai_name"))
      super(game_manager, name)
    end
  end
end
