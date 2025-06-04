# frozen_string_literal: true

require_relative "../lib/player"

describe ConnectFour::Player do
  subject(:player) { described_class.new }
  describe "#edit_name" do
    context "when a name is provided" do
      it "changes the name from the default value" do
        new_name = "Picard"
        expect { player.edit_name(new_name) }.to change { player.name }.from("Player").to(new_name)
      end
    end

    context "when a name is not provided" do
      it "uses the default value as name" do
        expect(player.edit_name).to eq("Player")
      end
    end
  end
end
