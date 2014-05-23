require './game'
require './player'

describe "Game" do

	let(:x) { Player.new }
	let(:y) { Player.new }

	describe "#new" do
		it "creates an empty game board" do
			game = Game.new(x, y)
			game.available_spaces.length.should eq 9
		end
	end

	describe "#make_play" do

		
		it "plays both moves" do
			game = Game.new(x, y)
			game.make_play!
			game.available_spaces.length.should eq 7
		end
	end
end
