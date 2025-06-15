# frozen_string_literal: true

module ConsoleGame
  # Logic module for the game Connect Four
  module ConnectFourLogic
    # A hash of lambda functions for calculating movement in 8 directions on a grid
    DIRECTIONS = {
      n: ->(value, step, row) { value + row * step },
      ne: ->(value, step, row) { value + row * step + step },
      e: ->(value, step, _row) { value + step },
      se: ->(value, step, row) { value - row * step + step },
      s: ->(value, step, row) { value - row * step },
      sw: ->(value, step, row) { value - row * step - step },
      w: ->(value, step, _row) { value - step },
      nw: ->(value, step, row) { value + row * step - step }
    }.freeze

    # Recursively find the next value depending on direction
    # @param value [Integer] start value
    # @param direction [Symbol] see DIRECTIONS for available options. E.g., :e for count from left to right
    # @param combination [Array<Integer>] default value is an empty array
    # @param length [Integer] expected array length
    # @param bound [Array<Integer>] grid size `[row, col]`
    # @return [Array<Integer>] array of numbers
    def direction(value = 0, direction = :e, combination = nil, length: 4, bound: [7, 6])
      combination ||= [value]
      arr_size = combination.size
      return combination if arr_size == length

      row, _col = bound
      next_value = DIRECTIONS.fetch(direction) do |key|
        raise ArgumentError, "Invalid direction: #{key}"
      end.call(value, arr_size, row)

      if arr_size > 1
        return [] if out_of_bound?(next_value, bound)
        return [] if not_one_unit_apart?(direction, value, combination, row)
      end

      direction(value, direction, combination + [next_value], length: length, bound: bound)
    end

    # Helper method to check for out of bound cases for top and bottom borders
    # @param value [Integer]
    # @param bound [Array<Integer>] grid size `[row, col]`
    # @return [Boolean]
    def out_of_bound?(value, bound)
      value.negative? || value > bound.reduce(:*) - 1
    end

    # Helper method to check for out of bound cases for left and right borders
    # @param direction [Symbol] see DIRECTIONS for available options. E.g., :e for count from left to right
    # @param start_value [Integer]
    # @param value_arr [Array<Integer>]
    # @param row [Integer]
    # @return [Boolean]
    def not_one_unit_apart?(direction, start_value, values_arr, row)
      return false unless %i[e w ne nw se sw].include?(direction)

      ((start_value % row - values_arr.last % row).abs - values_arr.size).abs != 1
    end

    # Convert coordinate array to cell position
    def to_pos(coord, board_size = 7)
      row, col = coord
      (row * board_size) + col
    end

    # Convert cell position to coordinate array
    def to_coord(pos, board_size = 7)
      pos.divmod(board_size)
    end
  end
end
