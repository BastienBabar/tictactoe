require 'rails_helper'

RSpec.describe PlayerList, type: :model do
  let(:x) { "Player X" }
  let(:o) { "Player O" }

  let(:p1) { PlayerList::Player.new("x", "Player X") }
  let(:p2) { PlayerList::Player.new("o", "Player O") }
  describe "players" do
    context "new" do
      it do
        pl = PlayerList.new(x, o, 0)
        expect(pl.players).to eq [p1, p2]
        expect(pl.current_player).to eq 0
        expect(pl.current).to eq p1
      end
    end

    context 'next' do
      it do
        pl = PlayerList.new(x, o, 0)
        pl.next!
        expect(pl.current).to eq p2
      end
    end
  end
end
