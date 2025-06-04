# frozen_string_literal: true

require_relative "../lib/connect_four"

describe ConnectFour::Board do
  describe "#generate_board" do
    context "when given a parameter of 7 and 6" do
      subject(:board) { described_class.new(7, 6) }
      it "returns an array with 6 nested arrays that has 7 elements each" do
        result = board.generate_board
        expect(result.size).to eq(6)
        expect(result.all? { |e| e.size == 7 }).to be true
      end
    end
  end
end
