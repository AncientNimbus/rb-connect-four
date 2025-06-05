# frozen_string_literal: true

require_relative "console"
require_relative "base_game"
require_relative "player"

# Console Game System v2.0.0
module ConsoleGame
  # Game Manager for Console game
  class GameManager
    attr_reader :menu, :cli

    def initialize
      @menu = ConsoleMenu.new
      @cli = Console.new
      @p1 = Player.new
      @running = true
      @current_game = nil
    end

    # run the console game manager
    def run
      puts "console is running"
      # puts menu.show
      puts cli.msg_printer(menu.show)
      puts "hit any key to exit the program"
      gets.chomp
      puts "~~bye~~"
    end
  end
end
