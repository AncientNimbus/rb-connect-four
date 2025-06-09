# frozen_string_literal: true

require_relative "console"
require_relative "base_game"
require_relative "player"

# Console Game System v2.0.0
module ConsoleGame
  # Game Manager for Console game
  class GameManager
    include Console
    attr_reader :apps, :menu
    attr_accessor :running, :current_game

    def initialize
      @running = true
      @apps = ["connect4"]
      @menu = ConsoleMenu.new(self)
      @p1 = Player.new(self)
      @current_game = nil
    end

    # run the console game manager
    def run
      # greet
      menu.show("console.ver")
      menu.show("console.menu")
      # lobby
      menu.handle_input(allow_empty: true) while @running
    end
  end
end
