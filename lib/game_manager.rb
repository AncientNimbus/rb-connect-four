# frozen_string_literal: true

require_relative "console"
require_relative "player"
require_relative "base_game"
require_relative "connect_four"

# Console Game System v2.0.0
module ConsoleGame
  # Game Manager for Console game
  class GameManager
    include Console
    attr_reader :apps, :menu
    attr_accessor :running, :current_game

    def initialize(lang: "en")
      @running = true
      @apps = { "connect4" => method(:connect_four) }
      @menu = ConsoleMenu.new(self, lang)
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

    def connect_four
      puts "Hello from #{self.class}"
      self.current_game = ConnectFour.new
    end
  end
end
