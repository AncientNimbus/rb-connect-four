# frozen_string_literal: true

module ConsoleGame
  # Base Game class
  class BaseGame
    attr_reader :game_manager, :input, :title, :player
    attr_accessor :state, :game_result

    # @param game_manager [ConsoleGame::GameManager]
    # @param input [ConsoleGame::ConsoleMenu]
    # @param title [String]
    def initialize(game_manager = nil, input = nil, title = "Base Game")
      @game_manager = game_manager
      @input = input
      @title = title
      @player = game_config[:player]
      @state = :created
      # @game_data = initialize_game_data
    end

    # Game config
    def game_config
      return nil if game_manager.nil?

      { player: game_manager.p1 }
    end

    # State machine

    # Start the game
    def start
      self.state = :playing
      show_intro
      setup_game
    end

    # Change game state to paused
    def pause
      self.state = :paused
    end

    # Change game state to playing
    def resume
      self.state = :playing
    end

    # Change game state to ended
    def end_game(result)
      self.state = :ended
      @game_result = result
      # show_end_screen
    end

    # Check if current game session is active
    def active?
      state == :playing
    end

    def update
      return unless active?

      handle_input
      update_game_logic
      render_game_state
      check_end_conditions
    end

    protected

    # Template methods - to be implemented by specific games
    def initialize_game_data
      raise NotImplementedError, "Subclasses must implement initialize_game_data"
    end

    def setup_game; end

    def show_intro
      system("clear")
      input.print_msg(F.s("console.msg.run", { app: title }, :yellow))
    end

    def handle_input
      raise NotImplementedError, "Subclasses must implement handle_input"
    end

    def update_game_logic
      raise NotImplementedError, "Subclasses must implement update_game_logic"
    end

    def render_game_state
      raise NotImplementedError, "Subclasses must implement render_game_state"
    end

    def check_end_conditions
      # Override in subclasses
    end

    def show_end_screen
      puts "Game Over! Result: #{@game_result}"
      # @display.pause
    end
  end
end
