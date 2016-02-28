require_relative 'spec_helper'
require_relative '../lib/ttt'

describe TTT do
  context "#new" do
    it "should initialize a new game" do
      position = TTT::Position.new(%w(-) * 9, "x") 
      position.board.should eq(%w(-) * 9)
      position.turn.should eq("x") 
    end

    it "should return correct board" do
      position = TTT::Position.new(%w{o - -
                                      - - x
                                      - - -}, "x")
      position.board.should eq(%w{o - -
                                  - - x
                                  - - -})
    end

    it "should return all moves possible" do
      position = TTT::Position.new()
      position.possible_moves.should eq((0..8).to_a)
    end
  end

  context "#move" do
    it "should make moves" do
      position = TTT::Position.new(%w{- - -
                                      - - -
                                      - - -}, "x")
      position.move(3).board.should == %w{- - -
                                          x - -
                                          - - -}
    end

    it "should return correct possible moves" do
      TTT::Position.new.move(6).possible_moves.should eq([0, 1, 2, 3, 4, 5, 7, 8])
    end
  end

  context "#winner" do
    context "should detect horizontal wins" do
      it { expect(TTT::Position.new(%w{o o o
                                       - - -
                                       - - -}, "o").win?("o")).to be true }

      it { expect(TTT::Position.new(%w{- - -
                                       o o o
                                       - - -}, "o").win?("o")).to be true }

      it { expect(TTT::Position.new(%w{- - -
                                       - - -
                                       o o o}, "o").win?("o")).to be true }
    end

    context "should detect vertical wins" do
      it { expect(TTT::Position.new(%w{x - -
                                       x - -
                                       x - -}, "x").win?("x")).to be true }

      it { expect(TTT::Position.new(%w{- x -
                                       - x -
                                       - x -}, "x").win?("x")).to be true }

      it { expect(TTT::Position.new(%w{- - x
                                       - - x
                                       - - x}, "x").win?("x")).to be true }
    end

    context "should detect diagonal wins" do
      it { expect(TTT::Position.new(%w{x - -
                                       - x -
                                       - - x}, "x").win?("x")).to be true }

      it { expect(TTT::Position.new(%w{- - o
                                       - o -
                                       o - -}, "o").win?("o")).to be true }
    end
  end
end
