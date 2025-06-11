# frozen_string_literal: true

require_relative "../lib/base_game"

describe ConsoleGame::BaseGame do
  describe "#initialize" do
    context "when game_manager is provided" do
      let(:mock_player) { double("Player") }
      let(:mock_game_manager) { double("GameManager", p1: mock_player) }
      let(:custom_title) { "Custom Game" }
      subject(:game) { described_class.new(mock_game_manager, custom_title) }

      it "sets the game_manager" do
        expect(game.game_manager).to eq(mock_game_manager)
      end

      it "sets the title" do
        expect(game.title).to eq(custom_title)
      end

      it "sets the player to game_manager.p1" do
        expect(game.player).to eq(mock_player)
      end

      it "sets the initial state to :created" do
        expect(game.state).to eq(:created)
      end
    end

    context "when game_manager is not provided" do
      subject(:game) { described_class.new }

      it "sets the game_manager to nil" do
        expect(game.game_manager).to be_nil
      end

      it "sets the title to default" do
        expect(game.title).to eq("Base Game")
      end

      it "sets the player to nil" do
        expect(game.player).to be_nil
      end

      it "sets the initial state to :created" do
        expect(game.state).to eq(:created)
      end
    end
  end
end
