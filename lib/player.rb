# frozen_string_literal: true

module ConsoleGame
  # Player class
  class Player
    @number_of_player = 0
    attr_reader :name

    def initialize(game_manager = nil, name = "")
      @game_manager = game_manager
      Player.add_player
      @name = "Player #{Player.total_player}" if name.empty?
      @moves = []
    end

    # Edit player name
    # @param name [String]
    def edit_name(name = "")
      return name if name.empty?

      @name = name
    end

    def self.add_player
      @number_of_player += 1
    end

    def self.total_player
      @number_of_player
    end
  end
end
