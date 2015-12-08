require 'rails_helper'
require 'matrix'

RSpec.describe Board, type: :model do
  describe 'new board' do
    let(:matrix) { Matrix.build(3) { '_'} }
    context do
      b = Board.new
      it { expect(b.matrix).to eq matrix }
    end
  end
end
