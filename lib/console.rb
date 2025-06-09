# frozen_string_literal: true

require_relative "file_utils"

F = FileUtils

module ConsoleGame
  # Game display & input manager for console game
  module Console
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
        # p command?(input)
        break if input.match?(reg) && (!input.empty? || allow_empty)

        msg = err_msg
      end
      input
    end

    # returns true if user input matches available commands
    # @param input [String] user input
    # @param commands [Array<String>] command string keys
    # @param flags [Array<String>] command pattern prefixes
    # @return [Boolean, Array<Boolean, String>] whether it is a command or not
    def command?(input, commands = %w[exit debug], flags: %w[-- -])
      case
      when input[0..1] == flags[0]
        input.delete_prefix!(flags[0])
      when input[0] == flags[1]
        input.delete_prefix!(flags[1])
      else
        return false
      end
      [true, commands.include?(input), input]
    end
  end

  # Game menu manager for console game
  class ConsoleMenu
    include Console

    attr_reader :commands

    def initialize(game_manager = nil)
      attr_reader :game_manager

      @game_manager = game_manager
      @commands = { "exit" => method(:quit), "ttfn" => method(:quit),
                    "help" => method(:help), "play" => method(:play) }
      @input_is_cmd = false
    end

    # process user input
    # @param msg [String] first print
    # @param err_msg [String] second print
    # @param reg [Regexp] pattern to match
    # @param allow_empty [Boolean] allow empty input value, default to false
    def handle_input(msg = F.s("console.msg.std"), err_msg: F.s("console.msg.err"), reg: /.*/, allow_empty: false)
      input = prompt_user(msg, err_msg: err_msg, reg: reg, allow_empty: allow_empty)
      return input if input.empty?

      input_arr = input.split(" ")
      @input_is_cmd, is_valid, cmd = command?(input_arr[0], commands)

      if @input_is_cmd
        is_valid ? commands[cmd].call(input_arr[1..]) : print_msg(F.s("console.cmd_err"))
      else
        input
      end
    end

    # Display the console menu
    # @param str [String] textfile key
    def show(str)
      print_msg(F.s(str))
    end

    def help(_arr = [])
      show("console.help")
    end

    # Launch a game
    # @param arr [Array<String>] optional arguments
    def play(arr = [])
      return print_msg(F.s("console.msg.gm_err")) unless game_manager

      if game_manager.apps.include?(arr[0])
        print_msg(F.s("console.msg.run", { app: arr[0] }))

        # game_manager.current_game
      else
        print_msg(F.s("console.msg.run_err"))
      end
    end

    # Exit sequences
    def quit(_arg = [])
      game_manager.running = false
      print_msg(F.s("console.exit"))
      exit
    end
  end
end
