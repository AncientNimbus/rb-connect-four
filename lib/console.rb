# frozen_string_literal: true

require_relative "file_utils"

F = FileUtils

module ConsoleGame
  # Game display & input manager for console game
  class Console
    # prompt message helper
    # @param msg [String] message to print
    # @param pre [String] message prefix
    # @param suf [String] message suffix
    # @param mode [Symbol] expecting the following symbols: `puts`, `print`, `p`
    def msg_printer(msg = "Using message printer", pre: "", suf: "", mode: :puts)
      return ArgumentError("Invalid mode used for this method") unless %i[puts print p].include?(mode)

      formatted_msg = pre + msg + suf
      method(mode).call(formatted_msg)
    end
  end

  # Game menu manager for console game
  class ConsoleMenu
    # Display the console menu
    def show
      F.s("console.menu")
    end
  end
end
