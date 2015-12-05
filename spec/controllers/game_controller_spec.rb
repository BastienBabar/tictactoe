require 'rails_helper'

RSpec.describe GameController, type: :controller do
  describe '#new' do
    context do
      before { get :new }
      it { expect(response.status).to eq 200 }
    end
  end

  describe '#init' do
    context do
      before {get :init}
      it { expect(response.status).to eq 200 }
    end
  end

  describe '#over' do
    context do
      before {get :over}
      it { expect(response.status).to eq 200 }
    end
  end

  describe '#turn' do
    context do
      before {get :turn}
      it { expect(response.status).to eq 200 }
    end
  end
end
