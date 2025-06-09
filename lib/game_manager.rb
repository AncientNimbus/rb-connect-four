# frozen_string_literal: true

require_relative "console"
require_relative "base_game"
require_relative "player"

# Console Game System v2.0.0
module ConsoleGame
  # Game Manager for Console game
  class GameManager
    include Console
    attr_reader :menu

    def initialize
      @menu = ConsoleMenu.new
      @p1 = Player.new
      @running = true
      @current_game = nil
    end

    # run the console game manager
    def run
      # greet
      menu.help
      # lobby
      menu.handle_input(allow_empty: true) while @running
    end
  end
end
