require "rails_helper"

RSpec.describe GameController, type: :controller do
  describe "#new" do
    context do
      before { get :new }
      it { expect(response.status).to eq 200 }
    end
  end

  describe "#init" do
    let(:params) do
      ActionController::Parameters.new(x: "Player x", o: "Player O")
    end

    before do
      allow(controller).to receive(:params).and_return(params)
    end

    context do
      before { post :init }
      it do
        board = Board.new
        players = PlayerList.new(params[:x], params[:o])
        expect(response.status).to eq 200
        expect(assigns(:players).players[0].name).to eq params[:x]
        expect(assigns(:players).players[1].name).to eq params[:o]
        expect(assigns(:board)).to eq board.matrix
        expect(request.session["board"]).to eq board.matrix
        expect(request.session["players"]).to eq players.players
        expect(request.session["current_player"]).to eq players.current_player
      end
    end
  end

  describe "#turn" do
    let(:params) do
      ActionController::Parameters.new(id: "1")
    end

    before do
      players = PlayerList.new("Player X", "Player O", 0)
      request.session["board"] = Board.new.matrix.to_a
      request.session["players"] = players.players
      request.session["current_player"] = "0"
      allow(controller).to receive(:params).and_return(params)
    end

    context do
      before { post :turn, format: "json" }

      it do
        expect(response.status).to eq 200
        expect(assigns(:symbol)).to eq "x"
        expect(assigns(:coordinates)).to eq [0, 1]
        expect(assigns(:finished)).to eq false
        expect(request.session["current_player"]).to eq 1
      end
    end
  end

  describe "#over" do
    context do
      before { get :over }
      it { expect(response.status).to eq 200 }
    end
  end
end
