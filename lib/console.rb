# frozen_string_literal: true

require_relative "file_utils"

F = FileUtils

module ConsoleGame
  # Game display & input manager for console game
  class Console
    # prompt user to collect input
    # @param msg [String] first print
    # @param err_msg [String] second print
    # @param reg [Regexp] pattern to match
    # @param allow_empty [Boolean] allow empty input value, default to false
    # @return [String] user input
    def prompt_user(msg = F.s("console.msg.std"), err_msg: F.s("console.msg.err"), reg: /.*/, allow_empty: false)
      input = ""
      loop do
        print_msg(msg, mode: :print)
        input = gets.chomp
        break if input.match?(reg) && (!input.empty? || allow_empty)

        msg = err_msg
      end
      input
    end

    # prompt message helper
    # @param msg [String] message to print
    # @param pre [String] message prefix
    # @param suf [String] message suffix
    # @param mode [Symbol] expecting the following symbols: `puts`, `print`, `p`
    def print_msg(msg = "Using message printer", pre: "", suf: "", mode: :puts)
      return ArgumentError("Invalid mode used for this method") unless %i[puts print p].include?(mode)

      formatted_msg = pre + msg + suf
      method(mode).call(formatted_msg)
    end

    # returns true if user input matches available commands
    # @param input [String] user input
    # @param commands [Array<String>] command string keys
    # @return [Boolean] whether it is a command or not
    def command?(input, commands = ["exit"])
      commands.include?(input.delete_prefix("-")) || commands.include?(input.delete_prefix("--"))
    end
  end

  # Game menu manager for console game
  class ConsoleMenu
    def initialize
      @commands = { "exit" => method(:exit), "help" => method(:help), "play" => method(:play) }
    end

    # Display the console menu
    def help
      F.s("console.menu")
    end

    # Launch a game
    def play
      F.s("Launching a game")
    end
  end
end
