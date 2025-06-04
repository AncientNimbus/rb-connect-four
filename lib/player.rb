# frozen_string_literal: true

module ConsoleGame
  # Player class
  class Player
    # @todo create player
    attr_reader :name

    def initialize(name = "Player")
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
