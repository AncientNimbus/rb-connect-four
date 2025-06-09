# frozen_string_literal: true

module ConsoleGame
  # Player class
  class Player
    # @todo create player
    attr_reader :name

    def initialize(game_manager = nil, name = "Player")
      @game_manager = game_manager
      @name = name
      @moves = []
    end

    # Edit player name
    # @param name [String]
    def edit_name(name = "")
      return @name if name.empty?

      @name = name
    end
  end
end
