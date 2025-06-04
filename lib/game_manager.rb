# frozen_string_literal: true

require_relative "console"
require_relative "base_game"
require_relative "player"

# Console Game System v2.0.0
module ConsoleGame
  # Game Manager for Console game
  class GameManager
    def initialize
      @menu = ConsoleMenu.new
      @console = Console.new
      @p1 = Player.new
      @running = true
      @current_game = nil
    end

    # run the console game manager
    def run
      puts "console is running"
      puts "loading menu"
      puts "hit any key to exit the program"
      gets.chomp
      puts "~~bye~~"
    end
  end
end
