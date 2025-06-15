# frozen_string_literal: true

require_relative "../lib/connect_four_logic"

describe ConsoleGame::ConnectFourLogic do
  let(:dummy_class) { Class.new { include ConsoleGame::ConnectFourLogic } }
  subject(:logic_test) { dummy_class.new }

  describe "#direction" do
    context "when starting value is 0, and bound is a 7 x 6 grid" do
      start_value = 0
      arr = nil
      arr_length = 4
      bound = [7, 6]

      it "returns an empty array when direction is the north west" do
        direction = :nw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns a sequence of positions to the north" do
        direction = :n
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([0, 7, 14, 21])
      end

      it "returns a sequence of positions to the north east" do
        direction = :ne
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([0, 8, 16, 24])
      end

      it "returns a sequence of positions to the east" do
        direction = :e
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([0, 1, 2, 3])
      end

      it "returns an empty array when direction is the south east" do
        direction = :se
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the south" do
        direction = :s
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the south west" do
        direction = :sw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the west" do
        direction = :w
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end
    end

    context "when starting value is 6, and bound is a 7 x 6 grid" do
      start_value = 6
      arr = nil
      arr_length = 4
      bound = [7, 6]

      it "returns a sequence of positions to the north west" do
        direction = :nw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([6, 12, 18, 24])
      end

      it "returns a sequence of positions to the north" do
        direction = :n
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([6, 13, 20, 27])
      end

      it "returns an empty array when direction is the north east" do
        direction = :ne
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the east" do
        direction = :e
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the south east" do
        direction = :se
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the south" do
        direction = :s
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the south west" do
        direction = :sw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns a sequence of positions to the west" do
        direction = :w
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([6, 5, 4, 3])
      end
    end

    context "when starting value is 38, and bound is a 7 x 6 grid" do
      start_value = 38
      arr = nil
      arr_length = 4
      bound = [7, 6]

      it "returns an empty array when direction is the north west" do
        direction = :nw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the north" do
        direction = :n
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when direction is the north east" do
        direction = :ne
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns a sequence of positions to the east" do
        direction = :e
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([38, 39, 40, 41])
      end

      it "returns a sequence of positions to the south east" do
        direction = :se
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([38, 32, 26, 20])
      end

      it "returns a sequence of positions to the south" do
        direction = :s
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([38, 31, 24, 17])
      end

      it "returns a sequence of positions to the south west" do
        direction = :sw
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([38, 30, 22, 14])
      end

      it "returns a sequence of positions to the west" do
        direction = :w
        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([38, 37, 36, 35])
      end
    end

    context "when it is an edge case, and bound is a 7 x 6 grid" do
      arr = nil
      arr_length = 4
      bound = [7, 6]
      it "returns a sequence of positions to the east when no argument is provided" do
        result = logic_test.direction
        expect(result).to eq([0, 1, 2, 3])
      end

      it "returns an empty array when starting value is larger than bound" do
        start_value = 42
        direction = :e

        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "returns an empty array when starting value is smaller than bound" do
        start_value = -1
        direction = :e

        result = logic_test.direction(start_value, direction, arr, length: arr_length, bound: bound)
        expect(result).to eq([])
      end

      it "raise an error when direction symbol is incorrect" do
        start_value = 41
        direction = :test
        expect do
          logic_test.direction(start_value, direction)
        end.to raise_error(ArgumentError, "Invalid path: test")
      end
    end
  end

  describe "#out_of_bound?" do
    context "when value is negative, and bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns true if value is -1" do
        value = -1
        expect(logic_test.out_of_bound?(value, bound)).to be true
      end
    end

    context "when value is positive and greater than bound, where bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns true if value is 42" do
        value = 42
        expect(logic_test.out_of_bound?(value, bound)).to be true
      end
    end

    context "when value is positive and within bound, where bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns false if value is 41" do
        value = 41
        expect(logic_test.out_of_bound?(value, bound)).to be false
      end
    end
  end

  describe "#not_one_unit_apart?" do
    context "when direction is east and start value is 4, where bound is a 7 x 6 grid" do
      start_value = 4
      direction = :e
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [4, 5, 6, 7]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value of the previous value" do
        arr = [4, 6]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value of the previous value" do
        arr = [4, 5]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end

    context "when direction is west and start value is 37, where bound is a 7 x 6 grid" do
      start_value = 37
      direction = :w
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [37, 36, 35, 34]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value of the previous value" do
        arr = [37, 35]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value of the previous value" do
        arr = [37, 36]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end
    context "when direction is north east and start value is 25, where bound is a 7 x 6 grid" do
      direction = :ne
      start_value = 25
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [25, 33, 41, 49]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value one row above" do
        arr = [25, 34]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value one row above" do
        arr = [25, 33]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end
    context "when direction is north west and start value is 23, where bound is a 7 x 6 grid" do
      direction = :nw
      start_value = 23
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [23, 29, 35, 41]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value one row above" do
        arr = [23, 28]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value one row above" do
        arr = [23, 29]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end
    context "when direction is south east and start value is 18, where bound is a 7 x 6 grid" do
      direction = :se
      start_value = 18
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [18, 12, 6, 0]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value one row below" do
        arr = [18, 13]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value one row below" do
        arr = [18, 12]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end
    context "when direction is south west and start value is 16, where bound is a 7 x 6 grid" do
      direction = :sw
      start_value = 16
      row = 7
      it "returns true when the last array value is out of bound" do
        arr = [16, 8, 0, -6]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns true when the last array value is not the next immediate value one row below" do
        arr = [16, 7]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be true
      end

      it "returns false when the last array value is the next immediate value one row below" do
        arr = [16, 8]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end

    context "when it is an edge case, and bound is a 7 x 6 grid" do
      start_value = 16
      row = 7
      it "returns false when direction is out of scope" do
        direction = :n
        arr = [0, 1, 2, 3]
        result = logic_test.not_one_unit_apart?(direction, start_value, arr, row)
        expect(result).to be false
      end
    end
  end

  describe "#to_pos" do
    context "when coord is a valid integer array, and bound is a 7 x 6 grid, converts coordinates to position" do
      bound = [7, 6]
      it "returns position value 0 when coordinates is [0, 0]" do
        coord = [0, 0]
        result = logic_test.to_pos(coord, bound)
        expect(result).to eq(0)
      end

      it "returns position value 24 when coordinates is [3, 3]" do
        coord = [3, 3]
        result = logic_test.to_pos(coord, bound)
        expect(result).to eq(24)
      end

      it "returns position value 41 when coordinates is [5, 6]" do
        coord = [5, 6]
        result = logic_test.to_pos(coord, bound)
        expect(result).to eq(41)
      end
    end

    context "when coord is not a valid integer array, and bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "raise an error if the coord larger than bound" do
        coord = [6, 6]
        expect do
          logic_test.to_pos(coord, bound)
        end.to raise_error(ArgumentError, "#{coord} is out of bound!")
      end

      it "raise an error if the coord smaller than bound" do
        coord = [-1, 0]
        expect do
          logic_test.to_pos(coord, bound)
        end.to raise_error(ArgumentError, "#{coord} is out of bound!")
      end
    end
  end

  describe "#to_coord" do
    context "when pos is a valid value, and bound is a 7 x 6 grid, converts position to coordinates" do
      bound = [7, 6]
      it "returns coordinates value [0, 0] when positional value is 0" do
        pos = 0
        expect(logic_test.to_coord(pos, bound)).to eq([0, 0])
      end

      it "returns coordinates value [3, 3] when positional value is 24" do
        pos = 24
        expect(logic_test.to_coord(pos, bound)).to eq([3, 3])
      end

      it "returns coordinates value [5, 6] when positional value is 41" do
        pos = 41
        expect(logic_test.to_coord(pos, bound)).to eq([5, 6])
      end
    end

    context "when pos is not a valid value, and bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "raise an error if the value is larger than bound" do
        pos = 42
        expect do
          logic_test.to_coord(pos, bound)
        end.to raise_error(ArgumentError, "#{pos} is out of bound!")
      end

      it "raise an error if the value is smaller than bound" do
        pos = -1
        expect do
          logic_test.to_coord(pos, bound)
        end.to raise_error(ArgumentError, "#{pos} is out of bound!")
      end
    end
  end
end
