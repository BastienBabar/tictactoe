require 'rails_helper'

RSpec.describe GameController, type: :controller do
  describe '#new' do
    context do
      before { get :new }
      it { expect(response.status).to eq 200 }
    end
  end

  describe '#init' do
    let(:params) do
      ActionController::Parameters.new({
                                           x: 'Player x',
                                           o: 'Player O'
                                       })
    end

    before do
      allow(controller).to receive(:params).and_return(params)
    end

    context do
      before { post :init, format: 'json' }
      it { expect(response.status).to eq 200 }
      it { expect(assigns(:x)).to eq params[:players][:x]}
      it { expect(assigns(:o)).to eq params[:players][:o]}
      it { expect(request.session['board']).to eq Board.new.matrix }
      it { expect(request.session['players']).to eq params[:players][:players] }
      it { expect(request.session['current_player']).to eq params[:players][:current_player] }
    end
  end

  describe '#over' do
    context do
      before { get :over }
      it { expect(response.status).to eq 200 }
    end
  end

  describe '#turn' do
    context do
      before { get :turn }
      it { expect(response.status).to eq 200 }
    end
  end
end
