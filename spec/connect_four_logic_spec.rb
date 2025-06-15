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
        end.to raise_error(ArgumentError, "Invalid direction: test")
      end
    end
  end

  describe "#out_of_bound?" do
    context "when value is negative, and bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns true" do
        value = -1
        expect(logic_test.out_of_bound?(value, bound)).to be true
      end
    end

    context "when value is positive and greater than bound, where bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns true" do
        value = 42
        expect(logic_test.out_of_bound?(value, bound)).to be true
      end
    end

    context "when value is positive and within bound, where bound is a 7 x 6 grid" do
      bound = [7, 6]
      it "returns false" do
        value = 41
        expect(logic_test.out_of_bound?(value, bound)).to be false
      end
    end
  end
end
